import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/translations/strings_enum.dart';
import 'package:asas/app/widgets/edit_text.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:asas/app/widgets/phone_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../controllers/owner_signup_controller.dart';

class OwnerSignupView extends GetView<OwnerSignupController> {
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
                              Strings.Register_a_new_service_provider.tr,
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
                              hint: Strings.Service_Provider_Name.tr,
                              horizontal: 0,
                            ),
                            EditText(
                              controlName: 'name_corporation',
                              hint: Strings.name_corporation2.tr,
                              horizontal: 0,
                            ),
                            EditText(
                              controlName: 'name_corporation_ar',
                              hint: Strings.name_corporation_ar.tr,
                              horizontal: 0,
                            ),
                            PhoneInput(haseFormGroup: true,),
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
                              inputAction: TextInputAction.done,
                            ),
                            SizedBox(height: 40,),
                            MyButton(title: Strings.tracking.tr, onTap: controller.signup),
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
