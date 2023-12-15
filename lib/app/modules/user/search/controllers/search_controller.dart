import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/data/model/company_type.dart';
import 'package:asas/app/data/model/my_location.dart';
import 'package:asas/app/data/model/program.dart';
import 'package:asas/app/data/model/program_type.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';

class SearchControllerV extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TextEditingController searchController;
  late TextEditingController programSearchController;

  List<Company> companyList = [];
  ScrollController companyScrollController = ScrollController();
  int companyTotalPages = 0;
  int companyCurrentPage = 1;
  ApiCallStatus companyStatus = ApiCallStatus.holding;

  List<Program> programList = [];
  ScrollController programScrollController = ScrollController();
  int programTotalPages = 0;
  int programCurrentPage = 1;
  ApiCallStatus programStatus = ApiCallStatus.holding;

  int? actionId;
  int? idTypeProgram;

  late TabController tabBarController;

  List<ProgramType> programTypeList = [];

  String lastCalled = "";

  filter(BuildContext? context, int? id, int page) async {
    lastCalled = "filter";
    if (context != null) {
      actionId = id;
      Get.back();
      searchController.clear();
      FocusScope.of(context).requestFocus(FocusNode());
    }

    companyStatus = ApiCallStatus.loading;
    update(['company']);
    if (actionId == 1 || actionId == null) {
      if (page == 1) {
        companyStatus = ApiCallStatus.loading;
        update(['company']);
      } else {
        CustomLoading.showLoading(msg: Strings.load_more.tr);
      }

      CompanyResponse? data =
          await UserRepository().getCompaniesByCountryAndCityId(page);

      if (page != 1) {
        CustomLoading.cancelLoading();
      }

      if (data != null && data.companies!.isNotEmpty) {
        companyStatus = ApiCallStatus.success;

        if (page == 1) {
          companyList = data.companies!;
        } else {
          if (data.companies!.isNotEmpty) {
            companyList.addAll(data.companies!);
            _animateToOffset(companyScrollController.initialScrollOffset);
          }
        }

        companyTotalPages = data.lastPage!;
        companyCurrentPage = data.currentPage!;
      } else if (data != null && data.companies!.isEmpty) {
        companyStatus = ApiCallStatus.empty;
      } else {
        companyStatus = ApiCallStatus.failed;
      }
    } else if (actionId == 2) {
      if (page == 1) {
        companyStatus = ApiCallStatus.loading;
        update(['company']);
      } else {
        CustomLoading.showLoading(msg: Strings.load_more.tr);
      }

      CompanyResponse? data =
          await UserRepository().getDistricts(page,5,4 );

      if (page != 1) {
        CustomLoading.cancelLoading();
      }

      if (data != null && data.companies!.isNotEmpty) {
        companyStatus = ApiCallStatus.success;

        if (page == 1) {
          companyList = data.companies!;
        } else {
          if (data.companies!.isNotEmpty) {
            companyList.addAll(data.companies!);
            _animateToOffset(companyScrollController.initialScrollOffset);
          }
        }

        companyTotalPages = data.lastPage!;
        companyCurrentPage = data.currentPage!;
      } else if (data != null && data.companies!.isEmpty) {
        companyStatus = ApiCallStatus.empty;
      } else {
        companyStatus = ApiCallStatus.failed;
      }
    } else if (actionId == 3) {
      if (page == 1) {
        companyStatus = ApiCallStatus.loading;
        update(['company']);
      } else {
        CustomLoading.showLoading(msg: Strings.load_more.tr);
      }

      CompanyResponse? data = await UserRepository().getNewest(page, 5,4);

      if (page != 1) {
        CustomLoading.cancelLoading();
      }

      if (data != null && data.companies!.isNotEmpty) {
        companyStatus = ApiCallStatus.success;

        if (page == 1) {
          companyList = data.companies!;
        } else {
          if (data.companies!.isNotEmpty) {
            companyList.addAll(data.companies!);
            _animateToOffset(companyScrollController.initialScrollOffset);
          }
        }

        companyTotalPages = data.lastPage!;
        companyCurrentPage = data.currentPage!;
      } else if (data != null && data.companies!.isEmpty) {
        companyStatus = ApiCallStatus.empty;
      } else {
        companyStatus = ApiCallStatus.failed;
      }
    } else if (actionId == 4) {
      if (page == 1) {
        companyStatus = ApiCallStatus.loading;
        update(['company']);
      } else {
        CustomLoading.showLoading(msg: Strings.load_more.tr);
      }

      CompanyResponse? data = await UserRepository().getTopRatedCompany(page);

      if (page != 1) {
        CustomLoading.cancelLoading();
      }

      if (data != null && data.companies!.isNotEmpty) {
        companyStatus = ApiCallStatus.success;

        if (page == 1) {
          companyList = data.companies!;
        } else {
          if (data.companies!.isNotEmpty) {
            companyList.addAll(data.companies!);
            _animateToOffset(companyScrollController.initialScrollOffset);
          }
        }

        companyTotalPages = data.lastPage!;
        companyCurrentPage = data.currentPage!;
      } else if (data != null && data.companies!.isEmpty) {
        companyStatus = ApiCallStatus.empty;
      } else {
        companyStatus = ApiCallStatus.failed;
      }
    } else if (actionId == 5) {
      if (page == 1) {
        companyStatus = ApiCallStatus.loading;
        update(['company']);
      } else {
        CustomLoading.showLoading(msg: Strings.load_more.tr);
      }

      final List<MyLocation>? list = PreferenceUtils.getMyLocations();
      MyLocation? location;
      if (list != null) {
        for (var item in list) {
          if (item.isSelected!) {
            location = item;
          }
        }
      }

      CompanyResponse? data = await UserRepository()
          .getClosest(page, 4, location!.latitude!, location.longitude!,4);

      if (page != 1) {
        CustomLoading.cancelLoading();
      }

      if (data != null && data.companies!.isNotEmpty) {
        companyStatus = ApiCallStatus.success;

        if (page == 1) {
          companyList = data.companies!;
        } else {
          if (data.companies!.isNotEmpty) {
            companyList.addAll(data.companies!);
            if (companyScrollController.hasClients) {
              _animateToOffset(companyScrollController.initialScrollOffset);
            }
          }
        }

        companyTotalPages = data.lastPage!;
        companyCurrentPage = data.currentPage!;
      } else if (data != null && data.companies!.isEmpty) {
        companyStatus = ApiCallStatus.empty;
      } else {
        companyStatus = ApiCallStatus.failed;
      }
    }

    update(['company']);
  }

  companySearch(int page, String query) async {
    lastCalled = "companySearch";
    if (page == 1) {
      companyStatus = ApiCallStatus.loading;
      update(['company']);
    } else {
      CustomLoading.showLoading(msg: Strings.load_more.tr);
    }

    CompanyResponse? data = await UserRepository().companySearch(page, query);

    if (page != 1) {
      CustomLoading.cancelLoading();
    }

    if (data != null && data.companies!.isNotEmpty) {
      companyStatus = ApiCallStatus.success;

      if (page == 1) {
        companyList = data.companies!;
      } else {
        if (data.companies!.isNotEmpty) {
          companyList.addAll(data.companies!);
          _animateToOffset(companyScrollController.initialScrollOffset);
        }
      }

      companyTotalPages = data.lastPage!;
      companyCurrentPage = data.currentPage!;
    } else if (data != null && data.companies!.isEmpty) {
      companyStatus = ApiCallStatus.empty;
    } else {
      companyStatus = ApiCallStatus.failed;
    }
    update(['company']);
  }

  programSearch(int page, String query, idTypeProgram) async {
    if (idTypeProgram == null) {
      return;
    }
    if (page == 1) {
      programStatus = ApiCallStatus.loading;
      update(['programList']);
    } else {
      CustomLoading.showLoading(msg: Strings.load_more.tr);
    }

    ProgramResponse? data =
        await UserRepository().programsSearch(page, idTypeProgram, query);

    if (page != 1) {
      CustomLoading.cancelLoading();
    }

    if (data != null && data.programs!.isNotEmpty) {
      programStatus = ApiCallStatus.success;

      if (page == 1) {
        programList = data.programs!;
      } else {
        if (data.programs!.isNotEmpty) {
          programList.addAll(data.programs!);
          _programAnimateToOffset(programScrollController.offset + (75 * 2));
        }
      }

      programTotalPages = data.lastPage!;
      programCurrentPage = data.currentPage!;
    } else if (data != null && data.programs!.isEmpty) {
      programStatus = ApiCallStatus.empty;
    } else {
      programStatus = ApiCallStatus.failed;
    }
    update(['programList']);
  }

  void _animateToOffset(double offset) {
    companyScrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _programAnimateToOffset(double offset) {
    programScrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  getCompaniesNextPage() {
    if (companyCurrentPage < companyTotalPages) {
      if (lastCalled == "filter") {
        filter(null, null, companyCurrentPage + 1);
      } else {
        companySearch(companyCurrentPage + 1, searchController.text);
      }
    }
  }

  getProgramNextPage() {
    if (programCurrentPage < programTotalPages) {
      programSearch(
          programCurrentPage + 1, programSearchController.text, idTypeProgram);
    }
  }

  setProgramType(int id) {
    idTypeProgram = id;
    programSearch(1, programSearchController.text, idTypeProgram);
    update(['program']);
  }

  getProgramTypes() async {
    CustomLoading.showLoading();
    final programs = await PortalRepository().getProgramTypes();
    CustomLoading.cancelLoading();
    if (programs != null) {
      programTypeList = programs;
    } else {
      Future.delayed(Duration(seconds: 5), () {
        getProgramTypes();
      });
    }
    update(['program']);
  }

  List<CompanyType> companyTypeList = [];

  String getTypeName(String typeId) {
    print('basic $typeId');
    if (typeId == '-') {
      typeId = '1';
    }
    return companyTypeList
            .firstWhere((element) => element.id.toString() == typeId)
            .typeNameAr ??
        "";
  }

  getTypes() async {
    CustomLoading.showLoading();
    final companyTypes = await PortalRepository().getCompanyTypes();
    CustomLoading.cancelLoading();

    if (companyTypes != null) {
      companyTypeList = companyTypes;
    }

    getProgramTypes();
    filter(
      null,
      null,
      1,
    );
  }

  @override
  void onInit() {
    super.onInit();
    tabBarController = TabController(length: 2, vsync: this);

    searchController = TextEditingController();
    searchController.addListener(() {
      if (searchController.text.isNotEmpty && searchController.text != '') {
        companySearch(1, searchController.text);
      } else {
        filter(null, null, 1);
      }
    });

    programSearchController = TextEditingController();
    programSearchController.addListener(() {
      if (programSearchController.text.isNotEmpty) {
        programSearch(1, programSearchController.text, idTypeProgram);
      }
      //else{
      // programSearch(1, null, idTypeProgram);
      // }
    });

    companyScrollController.addListener(() {
      if (companyScrollController.position.atEdge) {
        bool isTop = companyScrollController.position.pixels == 0;
        if (!isTop) {
          getCompaniesNextPage();
        }
      }
    });

    programScrollController.addListener(() {
      if (programScrollController.position.atEdge) {
        bool isTop = programScrollController.position.pixels == 0;
        if (!isTop) {
          getProgramNextPage();
        }
      }
    });

    getTypes();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    tabBarController.dispose();
    programScrollController.dispose();
    programSearchController.dispose();
  }
}
