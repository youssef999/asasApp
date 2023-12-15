import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/data/model/program.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/dialog_utils.dart';
import 'package:get/get.dart';

import '../../../../data/repository/user_repository.dart';
import '../../../../translations/strings_enum.dart';

class UserProgramDetailsController extends GetxController {
  late Program program;
  late Company? company;

  @override
  void onInit() {
    program = Get.arguments[0];
    company = Get.arguments[1];
    getProgram();
    super.onInit();
  }

  addStudentToProgram(List<int> studentsId) async {
    String servicesIds = "";
    for (var item in program.service!) {
      if (item.selected) {
        servicesIds += "${item.id}";
      }
    }

    String childIds = studentsId.join(",").toString();

    print("ddlk $childIds");
    print("ddlk2 ${program.id!}");
    print("ddlk3 $servicesIds");
    CustomLoading.showLoading();
    final result = await UserRepository()
        .addStudentToProgram(childIds, program.id!, servicesIds);
    CustomLoading.cancelLoading();

    if (result != null) {
      DialogUtils.showBookingDoneDialog(Get.context!, () => Get.back(), result);
    }
  }

  selectStudent() async {
    CustomLoading.showLoading();
    final result = await UserRepository().getStudentsNotReserved(program.id!);
    CustomLoading.cancelLoading();
    if (result != null) {
      if (result.isNotEmpty) {
        DialogUtils.showSelectStudentDialog(Get.context!, result,
            onDone: (List<int> studentsId) {
          if (studentsId.isEmpty) {
            CustomLoading.showWrongToast(
                msg: Strings.At_least_one_student_must_tested.tr);
          } else {
            Get.back();

            addStudentToProgram(studentsId);

            /// Add Comments
            /// Show Comments
          }
        });
      } else {
        CustomLoading.showWrongToast(msg: Strings.There_are_no_children.tr);
      }
    }
  }

  double priceAfterDiscount() {
    if (program.discount!.isNotEmpty) {
      return (program.getPrice() -
          (program.getPrice() *
              (int.parse(program.discount![0].priceRateDiscount!) / 100)));
    } else {
      return program.getPrice().toDouble();
    }
  }

  updateTotalPrice() {
    double amount = 0;
    program.service!.map((e) {
      if (e.selected) {
        amount += e.getPrice(
            program.coins, program.coins_name_ar, program.coins_name_en);
      }
    }).toList();
    program.priceAfterAddingService = (priceAfterDiscount() + amount).toInt();
    update(['priceAfter']);
  }

  getProgram() async {
    CustomLoading.showLoading();
    final result = await PortalRepository().getProgramById(program.id!);
    CustomLoading.cancelLoading();
    if (result != null) {
      program = result;
    }
    update(['main']);
    updateTotalPrice();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
