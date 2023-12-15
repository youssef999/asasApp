import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/translations/langs_controller.dart';
import 'package:asas/app/translations/localization_service.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/edit_text.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/user_intro_controller.dart';

class UserIntroView extends GetView<UserIntroController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset('assets/svg/welcom_top.svg'),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SvgPicture.asset('assets/svg/welcome_bottom.svg', fit: BoxFit.fill),
            ),

            ReactiveForm(
              formGroup: controller.form,
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: constraints.copyWith(
                        minHeight: constraints.maxHeight,
                        maxHeight: double.maxFinite,
                        maxWidth: double.infinity,
                        minWidth: constraints.maxWidth),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 45,),
                                Image.asset(
                                  "assets/images/logo_app.png",
                                  width: MediaQuery.of(context).size.width * 0.7,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 80),
                                  child: Text(
                                    Strings.Welcome.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(
                                        color: LightColors.TEXT_PRIMARY_COLOR),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      GetBuilder<UserIntroController>(
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
                                                    label: Strings.Choose_the_city.tr ,
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
                                                    hint: Strings.Choose_the_city.tr ,
                                                    dropdownHintText: Strings.Choose_the_city.tr ,
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
                                      MyButton(title: Strings.tracking.tr, onTap: ()=> controller.login()),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      SizedBox(
                                        height: 35.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // controller.launchURL("https://www.palgoals.com/");
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: const [
                                // Image.asset(
                                //   "",
                                //   height: 30,
                                // ),
                                Text(
                                  "development by L00ai Company",
                                  style: TextStyle(
                                      color: LightColors
                                          .TEXT_SECONDARY_COLOR,
                                      fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 80,
              left: 20,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Icon(Icons.language, color: Colors.white, size: 22),
                    items: LocalizationService.langs
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: LightColors.PRIMARY_COLOR,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )).toList(),
                    value: null,
                    onChanged: (value) {
                      LocalizationService().changeLocale(value!);
                    },
                    iconStyleData:IconStyleData(icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ), iconSize: 22,
                    iconEnabledColor: Colors.white,
                    ),
                    buttonStyleData:ButtonStyleData(height: 35,width:55 ,decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: LightColors.PRIMARY_COLOR
                    ) ,padding:const EdgeInsets.symmetric(horizontal: 5) ,elevation:0 ),
                    dropdownStyleData: DropdownStyleData( offset: const Offset(0, 0),width: 200,padding: null,maxHeight: 200,decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    elevation: 8,
                    scrollbarTheme:ScrollbarThemeData(thickness:MaterialStateProperty.all(6),radius:const Radius.circular(40) ,thumbVisibility:MaterialStateProperty.all(true))
                    ),
                    menuItemStyleData:MenuItemStyleData(height: 40,padding:const EdgeInsets.only(left: 14, right: 14), ),
                    
                    

                  ),
                ),
              ),
            ),

          ],
        )
    );
  }
}
