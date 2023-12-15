import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/translations/strings_enum.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/edit_text.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:asas/app/widgets/phone_input.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../theme/lightColors.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(),
        body: ReactiveForm(
            formGroup: controller.form,
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15,),
                              Text(
                                Strings.Registering_personal_data.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(
                                    color: LightColors.TEXT_PRIMARY_COLOR),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                Strings.Fill_in_the_following_fields.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                    color: LightColors.PRIMARY_COLOR,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              EditText(
                                controlName: 'name',
                                hint: Strings.user_name.tr,
                                horizontal: 0,
                              ),
                              PhoneInput(controller: controller.phoneController,),
                              // EditText(
                              //   controlName: 'name',
                              //   hint: "البريد الالكتروني  (اختياري)",
                              //   horizontal: 0,
                              // ),
                              Booster.verticalSpace(8),
                              GetBuilder<SignupController>(
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
                              Booster.verticalSpace(8),
                              EditText(
                                controlName: 'password',
                                hint: Strings.PASSWORD.tr,
                                horizontal: 0,
                                isSecure: true,
                              ),
                              EditText(
                                controlName: 're_password',
                                hint: Strings.confirm_password.tr,
                                horizontal: 0,
                                isSecure: true,
                              ),
                              SizedBox(height: 5,),

                              GetBuilder<SignupController>(
                                  id: "Checkbox",
                                  builder: (ctrl) {
                                    return Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          value: controller.checkbox,
                                          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                          fillColor: MaterialStateProperty.resolveWith(controller.getColor),
                                          onChanged: (bool? value) {
                                            controller.checkboxChange(value!);
                                          },
                                        ),
                                        const SizedBox(width: 6,),
                                        RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: "الموافقة على",
                                                    style: Theme.of(context).textTheme.bodyText2
                                                ),
                                                TextSpan(
                                                    text: " شروط الخصوصية",
                                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: LightColors.ACCENT_COLOR),
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        //Get.toNamed(Routes.PRIVACY, );
                                                        ctrl.launchURL(Constance.termsAndConditions);
                                                      }),
                                              ],
                                            )),
                                      ],
                                    );
                                  }
                              ),
                              SizedBox(height: 5,),
                              SizedBox(height: 40,),
                              MyButton(title: Strings.tracking.tr, onTap: ()=> controller.signup(),),
                              SizedBox(
                                height: 30.0,
                              ),
                              Align(
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: Strings.I_have_an_account.tr,
                                            style: Theme.of(context).textTheme.bodyText2
                                        ),
                                        TextSpan(
                                            text: Strings.sign_in.tr,
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: LightColors.PRIMARY_COLOR),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Get.back();
                                              }),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
    );
  }
}
