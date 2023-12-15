import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';

class UserCategoryController extends GetxController {
  late TextEditingController searchController ;

  late String typeName ;
  late int typeId ;


  List<Company> companyList = [];
  ScrollController companyScrollController = ScrollController();
  int companyTotalPages = 0;
  int companyCurrentPage = 1;
  ApiCallStatus companyStatus = ApiCallStatus.loading;



  getCompanies(int page, String? query) async {
    if(page == 1){
      companyStatus = ApiCallStatus.loading;
      update();
    }else{
      CustomLoading.showLoading(msg: Strings.load_more.tr);
    }


    CompanyResponse? data;

    if(query != null){
      data = await UserRepository().companyCategorySearch(page, typeId, query);
    }else{
      data = await UserRepository().getCompaniesByCategoryId(typeId, page);
    }


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

  void _animateToOffset(double offset) {
    companyScrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }



  getCompaniesNextPage(){
    if(companyCurrentPage < companyTotalPages){
      getCompanies(companyCurrentPage + 1, null);
    }
  }

  @override
  void onInit() {
    super.onInit();

    typeId = Get.arguments[0];
    typeName = Get.arguments[1];

    getCompanies(1, null);

    searchController = TextEditingController();
    searchController.addListener(() {
      if(searchController.text.isNotEmpty){
        getCompanies(1, searchController.text);
      }else{
        getCompanies(1, null);
      }
    });

    companyScrollController.addListener(() {
      if (companyScrollController.position.atEdge) {
        bool isTop = companyScrollController.position.pixels == 0;
        if (!isTop) {
          getCompaniesNextPage();
        }
      }
    });


  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    companyScrollController.dispose();
  }
}
