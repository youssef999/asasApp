import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';

class UserFavoriteController extends GetxController {

  List<Company> companyList = [];
  ScrollController companyScrollController = ScrollController();
  int companyTotalPages = 0;
  int companyCurrentPage = 1;
  ApiCallStatus companyStatus = ApiCallStatus.loading;

  getFav(int page) async {
    if(page == 1){
      companyStatus = ApiCallStatus.loading;
      update();
    }else{
      CustomLoading.showLoading(msg: Strings.load_more.tr);
    }

    CompanyResponse? data = await UserRepository().getFavorite(page);


    if(page != 1){
      CustomLoading.cancelLoading();
    }


    if(data != null && data.companies!.isNotEmpty){
      companyStatus = ApiCallStatus.success;

      if(page == 1){
        companyList = data.companies!;
      }else{
        if(data.companies!.isNotEmpty){
          companyList.addAll(data.companies!);
          _animateToOffset(companyScrollController.offset + (75 * 2));
        }
      }

      companyTotalPages = data.lastPage!;
      companyCurrentPage = data.currentPage!;

    }else if(data != null && data.companies!.isEmpty){
      companyStatus = ApiCallStatus.empty;
    }else{
      companyStatus = ApiCallStatus.failed;
    }
    update();
  }



  getFavNextPage(){
    if(companyCurrentPage < companyTotalPages){
      getFav(companyCurrentPage + 1);
    }
  }

  void _animateToOffset(double offset) {
    companyScrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }


  @override
  void onInit() {
    super.onInit();

    companyScrollController.addListener(() {
      if (companyScrollController.position.atEdge) {
        bool isTop = companyScrollController.position.pixels == 0;
        if (!isTop) {
          getFavNextPage();
        }
      }
    });

    getFav(1);

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    companyScrollController.dispose();
  }

}
