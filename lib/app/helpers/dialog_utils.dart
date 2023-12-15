import 'package:asas/app/data/model/program.dart';
import 'package:asas/app/data/model/student.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/programs_custom_radio.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:asas/app/widgets/student_custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../translations/strings_enum.dart';



class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static Future<String?> showBookingDoneDialog(BuildContext context, Function onDone, String text) async {

    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Booster.verticalSpace(28),
                  SvgPicture.asset('assets/svg/book_done.svg'),
                  Booster.verticalSpace(7),
                  Booster.textSecondaryTitle(context, Strings.our_end.tr),
                  Booster.verticalSpace(7),
                  Booster.textBody(context, text),
                  Booster.verticalSpace(28),
                  MyButton(title: Strings.completed.tr, onTap: ()=> onDone(),)
                ],
              ),
            ),
            //actionsOverflowDirection: VerticalDirection.down,
          );
        });
  }

  static void showDeleteDialog(BuildContext context,
      {required String title,
        required String content,
        String okBtnText = "حذف",
        String cancelBtnText = "إلغاء",
        required Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Booster.textTitle(context, title, color: LightColors.ACCENT_COLOR),
                const SizedBox(height: 15,),
                Booster.textBody(context, content, textAlign: TextAlign.center),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          okBtnFunction();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.redAccent, // foreground
                        ),
                        child: Text(okBtnText),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: LightColors.TEXT_PRIMARY_COLOR, backgroundColor: Colors.white, // foreground
                        ),
                        child: Text(cancelBtnText),
                      ),
                    ),
                  ],
                )
              ],
            ),
            actionsOverflowDirection: VerticalDirection.down,
          );
        });
  }


  static showConfirmDialog(BuildContext context, {required String title, required String body, required Function onConfirm, String? textButton , bool isDelete = false}) {
    if(textButton != Strings.Login.tr){
      textButton = Strings.delete.tr;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Booster.textTitle(context, title, color: LightColors.PRIMARY_COLOR),
                  Booster.verticalSpace(10),
                  Booster.textBody(context, body, color: LightColors.TEXT_PRIMARY_COLOR),
                  Booster.verticalSpace(25),
                  SizedBox(
                    height: 44,
                    child: Row(
                      children: [
                        Expanded(
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                onConfirm();
                              },
                              borderRadius: BorderRadius.circular(7),
                              child: Ink(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                decoration: BoxDecoration(
                                  color: isDelete ? LightColors.ICON_COLOR_DELETE : LightColors.ACCENT_COLOR,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  textButton!,
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
                        Booster.horizontalSpace(8),
                        Expanded(
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(7),
                              child: Ink(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                decoration: BoxDecoration(
                                    color: LightColors.TEXT_WHITE_COLOR,
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(color: LightColors.TEXT_PRIMARY_COLOR)
                                ),
                                child: Text(
                                  Strings.cancel.tr,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: LightColors.TEXT_PRIMARY_COLOR,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            //actionsOverflowDirection: VerticalDirection.down,
          );
        });
  }


  static Future<String?> showOtpDoneDialog(BuildContext context, Function onDone) async {

    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Booster.verticalSpace(28),
                  SvgPicture.asset('assets/svg/owner/otp_done.svg'),
                  Booster.verticalSpace(7),
                  Booster.textSecondaryTitle(context, Strings.our_end.tr),
                  Booster.verticalSpace(7),
                  Booster.textBody(context, Strings.successfully_registered.tr),
                  Booster.verticalSpace(28),
                  MyButton(title: Strings.completed.tr, onTap: ()=> onDone(),)
                ],
              ),
            ),
            //actionsOverflowDirection: VerticalDirection.down,
          );
        });
  }


  static Future<String?> showSelectStudentDialog(BuildContext context, List<Student> studentList,
      {required Function onDone}) async {

    List<int> studentIds = [];
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 10),
                  child: Booster.textSecondaryTitle(context, Strings.Select_children.tr ),
                ),
                StudentCustomRadio(
                    studentList: studentList,
                    onSelect: (value){
                      studentIds = value;
                    }
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 30),
                  child: MyButton(title: Strings.Complete_reservation.tr, onTap: ()=> onDone(studentIds),),
                )
              ],
            ),
            //actionsOverflowDirection: VerticalDirection.down,
          );
        });
  }

  static Future<String?> showCopyProgramDialog(BuildContext context, List<Program> programList,
      {required Function onDone}) async {

    int programId = 0;
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 10),
                  child: Booster.textSecondaryTitle(context, Strings.Choose.tr),
                ),
                ProgramsCustomRadio(
                    programList: programList,
                    onSelect: (value){
                      programId = value;
                    }
                    ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 30),
                  child: MyButton(title: Strings.Copy.tr, onTap: ()=> onDone(programId),),
                )
              ],
            ),
            //actionsOverflowDirection: VerticalDirection.down,
          );
        });
  }



}
