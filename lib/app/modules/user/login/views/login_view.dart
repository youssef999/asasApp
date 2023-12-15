import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/translations/strings_enum.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/edit_text.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../controllers/login_controller.dart';


class LoginView extends GetView<LoginController> {
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
                                    Strings.LOGIN.tr,
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
                                  child: AutofillGroup(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        EditText(
                                          controlName: 'name',
                                          hint: Strings.user_name.tr,
                                          horizontal: 0,
                                          autofillHints: AutofillHints.username,
                                        ),
                                        // PhoneInput(controller: controller.phoneController,),
                                        EditText(
                                          controlName: 'password',
                                          hint: Strings.PASSWORD.tr,
                                          horizontal: 0,
                                          isSecure: true,
                                          inputAction: TextInputAction.done ,
                                          autofillHints: AutofillHints.password,
                                          finishAutofill: true,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                Strings.FORGET_PASS.tr,
                                                style: Theme.of(context).textTheme.bodyText1?.copyWith(color: LightColors.TEXT_HINT_COLOR,),
                                              ),
                                            ),
                                          ],
                                        ),
                                        MyButton(title: Strings.signin.tr, onTap: ()=> controller.login(),),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Material(
                                          child: InkWell(
                                            onTap: () {
                                              Get.toNamed(Routes.SIGNUP);
                                            },
                                            borderRadius: BorderRadius.circular(7),
                                            child: Ink(
                                              width: double.infinity,
                                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(color: LightColors.ACCENT_COLOR),
                                                borderRadius: BorderRadius.circular(7),
                                              ),
                                              child: Text(
                                                Strings.Create_a_new_account.tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: LightColors.ACCENT_COLOR,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Booster.horizontalSpace(30),
                                // GestureDetector(
                                //   onTap: controller.onFacebookClicked,
                                //   child: Container(
                                //     width: 45,
                                //     height: 45,
                                //     margin: EdgeInsets.only(bottom: 20),
                                //     padding: EdgeInsets.all(8),
                                //     decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.circular(8),
                                //       boxShadow: [
                                //         BoxShadow(
                                //           color: Colors.black.withOpacity(0.1),
                                //           spreadRadius: 2,
                                //           blurRadius: 5
                                //         )
                                //       ]
                                //     ),
                                //     child: SvgPicture.asset("assets/svg/fb.svg"),
                                //   ),
                                // ),
                                // Booster.horizontalSpace(16),
                                // Container(
                                //   width: 45,
                                //   height: 45,
                                //   margin: EdgeInsets.only(bottom: 20),
                                //   padding: EdgeInsets.all(8),
                                //   decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.circular(8),
                                //       boxShadow: [
                                //         BoxShadow(
                                //             color: Colors.black.withOpacity(0.1),
                                //             spreadRadius: 2,
                                //             blurRadius: 5
                                //         )
                                //       ]
                                //   ),
                                //   child: SvgPicture.asset("assets/svg/google.svg"),
                                // ),
                                Booster.horizontalSpace(30),
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
                              children:  [
                                // Image.asset(
                                //   "",
                                //   height: 30,
                                // ),
                                Text(
                                  Strings.Basic_app_everything.tr,
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
          ],
        )
    );
  }
}
