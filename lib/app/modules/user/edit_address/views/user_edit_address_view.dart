import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/user_edit_address_controller.dart';

class UserEditAddressView extends GetView<UserEditAddressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.country_and_city.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            GetBuilder<UserEditAddressController>(
              builder: (ctrl){
                return Column(
                  children: [
                    CustomSearchableDropDown(
                      items: ctrl.countryList,
                      label: Strings.Choose_the_country.tr,
                      initialIndex: ctrl.getCountryIndex(),
                      decoration: BoxDecoration(
                          color: LightColors.EDIT_BACKGROUND_COLOR,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: LightColors.EDIT_BORDER_COLOR)),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      prefixIcon: SizedBox(),
                      labelStyle: TextStyle(
                          color: LightColors.TEXT_PRIMARY_COLOR, fontSize: 14),
                      dropDownMenuItems: ctrl.countryList.map((e) => e.nameAr).toList(),
                      hint: Strings.Choose_the_country.tr,
                      dropdownHintText: Strings.Choose_the_country.tr,
                      onChanged: (value) {
                        //id_typeProgram
                        if(value == null){
                          return;
                        }
                        controller.setCountryType(value.id);
                      },
                    ),
                    if(ctrl.showCity())
                      ...[
                        Booster.verticalSpace(16),
                        CustomSearchableDropDown(
                          items: ctrl.cityList,
                          label: Strings.Choose_the_city.tr,
                          initialIndex: ctrl.getCityIndex(),
                          decoration: BoxDecoration(
                              color: LightColors.EDIT_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: LightColors.EDIT_BORDER_COLOR)),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          prefixIcon: SizedBox(),
                          labelStyle: TextStyle(
                              color: LightColors.TEXT_PRIMARY_COLOR, fontSize: 14),
                          dropDownMenuItems: ctrl.cityList.map((e) => e.nameAr).toList(),
                          hint: Strings.Choose_the_city.tr,
                          dropdownHintText: Strings.Choose_the_city.tr,
                          onChanged: (value) {
                            //id_typeProgram
                            if(value == null){
                              return;
                            }
                            controller.setCityType(value.id);
                          },
                        ),
                      ]
                  ],
                );
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            MyButton(title: Strings.Save.tr, onTap: ()=> controller.login()),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 35.0,
            ),
          ],
        ),
      ),
    );
  }
}
