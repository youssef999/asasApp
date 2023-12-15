import 'package:asas/app/data/model/program.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/owner_shared_pref.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';

class OwnerProgramsController extends GetxController {

  List<Program> programList = [];
  ScrollController programScrollController = ScrollController();
  int programTotalPages = 0;
  int programCurrentPage = 1;
  ApiCallStatus programStatus = ApiCallStatus.loading;

  getPrograms(int page) async {
    if(page == 1){
      programStatus = ApiCallStatus.loading;
      update();
    }else{
      CustomLoading.showLoading(msg: Strings.load_more.tr);
    }
    final userId = OwnerSharedPref.getUserData()?.id;
     if(userId == null){
       CustomLoading.showWrongToast(msg: Strings.MUST_BE_LOGGED.tr);
       Get.back();
       return;
     }
    final data = await PortalRepository().getPrograms(userId, page);

    if(page != 1){
      CustomLoading.cancelLoading();
    }


    if(data != null && data.programs!.isNotEmpty){
      programStatus = ApiCallStatus.success;

      if(page == 1){
        programList = data.programs!;
      }else{
        if(data.programs!.isNotEmpty){
          programList.addAll(data.programs!);
          _animateToOffset(programScrollController.offset + (75 * 2));
        }
      }

      programTotalPages = data.lastPage!;
      programCurrentPage = data.currentPage!;

    }else if(data != null && data.programs!.isEmpty){
      programStatus = ApiCallStatus.empty;
    }else{
      programStatus = ApiCallStatus.failed;
    }
    update();
  }

  void _animateToOffset(double offset) {
    programScrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }



  getProgramsNextPage(){
    if(programCurrentPage < programTotalPages){
      getPrograms(programCurrentPage + 1);
    }
  }

  addProgram() async{
    final program = await Get.toNamed(Routes.OWNER_ADD_PROGRAM, arguments: [programList]);
    if(program!=null){
      programStatus = ApiCallStatus.success;
      programList.add(program);
      update();
    }
  }

  editProgram(int id, int index) async{
    final program = await Get.toNamed(Routes.OWNER_EDIT_PROGRAM, arguments: [id]);
    if(program!=null){
      programStatus = ApiCallStatus.success;
      programList[index] = program;
      update();
    }
  }

  deleteProgram(int id) async {
    Get.back();
    CustomLoading.showLoading();
    final data = await PortalRepository().deleteProgram(id);
    CustomLoading.cancelLoading();
    if(data){
      programList.removeWhere((element) => element.id == id);
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();

    getPrograms(programCurrentPage);

    programScrollController.addListener(() {
      if (programScrollController.position.atEdge) {
        bool isTop = programScrollController.position.pixels == 0;
        if (!isTop) {
          getProgramsNextPage();
        }
      }
    });



  }

  @override
  void onClose() {
    programScrollController.dispose();
  }
}
