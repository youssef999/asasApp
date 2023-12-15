import 'package:asas/app/helpers/dialog_utils.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/translations/strings_enum.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/edit_text.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../helpers/custom_loading.dart';
import '../../../../helpers/sharedPref.dart';
import '../../home/controllers/home_controller.dart';
import '../../my_drawer/controllers/my_drawer_controller.dart';
import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.Profile_personly.tr),
        centerTitle: true,
      ),
      body: ReactiveForm(
        formGroup: controller.form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditText(
              hint: Strings.Full_Name.tr,
              controlName: "name",
              inputType: TextInputType.name,
            ),
            EditText(
              hint: Strings.Telephone_number.tr,
              controlName: "phone",
              inputType: TextInputType.name,
            ),
            Booster.verticalSpace(8),
            GetBuilder<UserProfileController>(
              builder: (ctrl){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
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
                        ],
                      Booster.verticalSpace(16),
                      CustomSearchableDropDown(
                        items: ctrl.currencyList,
                        label: Strings.Choose_the_currency.tr,
                        initialIndex: ctrl.getCurrencyIndex(),
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
                        dropDownMenuItems: ctrl.currencyList.map((e) => e.coinsNameAr).toList(),
                        hint: Strings.Choose_the_currency.tr,
                        dropdownHintText: Strings.Choose_the_currency.tr,
                        onChanged: (value) {
                          //id_typeProgram
                          if(value == null){
                            return;
                          }
                          controller.setCurrency(value.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
           // Booster.verticalSpace(16),
            if(PreferenceUtils.getUserIsLogged() && PreferenceUtils.getUserData()!.name == "loai")
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextButton(onPressed: (){
                  DialogUtils.showDeleteDialog(context, title: "حذف الحساب", content: "هل أنت متأكد من حذف معلومات حسابك بشكل نهائي , سيتم تطبيق التغييرات بعد 30 من عدم تسجيل الدخول ."
                      , okBtnFunction: (){
                        /// TO DO
                        Get.back();
                        Get.find<MyDrawerController>().logout();
                      });
                }, child: Booster.textBody(context, "حذف معلومات حسابي", color: LightColors.PRIMARY_COLOR))),
            Booster.verticalSpace(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                child: InkWell(
                  onTap: ()=> controller.updateProfile(),
                  borderRadius:
                  BorderRadius.circular(7),
                  child: Ink(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0),
                    decoration: BoxDecoration(
                      color: LightColors.PRIMARY_COLOR,
                      borderRadius:
                      BorderRadius.circular(7),
                    ),
                    child: Text(
                      Strings.Save.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
