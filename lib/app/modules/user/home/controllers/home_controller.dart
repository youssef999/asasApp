import 'dart:async';
import 'dart:convert';
import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/data/model/company_type.dart';
import 'package:asas/app/data/repository/auth_repository.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/owner_shared_pref.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/translations/strings_enum.dart';
import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../../../../data/model/currency.dart';

class HomeController extends GetxController {
  Completer<GoogleMapController> mapCompleter = Completer();
  // map controller (to animate camera and update position)
  GoogleMapController? googleMapController;

  // marker for the current chalet location
  late Set<Marker> markers;
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  late Company company;
  final xOffset = 0.0.obs;
  final yOffset = 0.0.obs;
  final scaleFactor = 1.0.obs;
  final verticalMargin = 0.0.obs;
  final isDrawerOpen = false.obs;
  List<CompanyType> companyTypeList = [];
  ApiCallStatus companyTypesStatus = ApiCallStatus.loading;
  List<dynamic> mapList = []; // Declare the variable to store mapList data
  late CameraPosition cameraPosition;
  List<Company> companyList = [];
  ScrollController companyScrollController = ScrollController();
  int companyTotalPages = 0;
  int companyCurrentPage = 1;
  ApiCallStatus companyStatus = ApiCallStatus.loading;

  List<Company> topCompanyList = [];
  ApiCallStatus topCompanyStatus = ApiCallStatus.loading;

  getCompanyTypes() async {
    companyTypesStatus = ApiCallStatus.loading;
    update(['companyTypes']);
    final result = await PortalRepository().getCompanyTypes();
    if (result == null) {
      companyTypesStatus = ApiCallStatus.failed;
    } else if (result.isNotEmpty) {
      companyTypesStatus = ApiCallStatus.success;
      companyTypeList = result;
    } else {
      companyTypesStatus = ApiCallStatus.empty;
    }
    update(['companyTypes']);
  }

  getTop() async {
    topCompanyStatus = ApiCallStatus.loading;
    update(['topCompany']);
    final result = await UserRepository().getTopRatedCompany(1);
    if (result == null) {
      topCompanyStatus = ApiCallStatus.failed;
    } else if (result.companies!.isNotEmpty) {
      topCompanyStatus = ApiCallStatus.success;
      topCompanyList = result.companies!;
    } else {
      topCompanyStatus = ApiCallStatus.empty;
    }
    update(['topCompany']);
  }

  getCompanies(int page) async {
    if (page == 1) {
      companyStatus = ApiCallStatus.loading;
      update();
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
        companyList = [];
        for (var element in data.companies!) {
          if (element.idCompanyType == "1") {
            companyList.add(element);
          }
        }
        //companyList = data.companies!;
      } else {
        if (data.companies!.isNotEmpty) {
          companyList = [];
          for (var element in data.companies!) {
            if (element.idCompanyType == "1") {
              companyList.add(element);
            }
          }
          // companyList.addAll(data.companies!);
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
    update();
  }

  void _animateToOffset(double offset) {
    companyScrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  getCompaniesNextPage() {
    if (companyCurrentPage < companyTotalPages) {
      getCompanies(companyCurrentPage + 1);
    }
  }

  List<Currency> currencyList = [];

  getCurrency() async {
    CustomLoading.showLoading();
    final result = await PortalRepository().getCurrency();
    CustomLoading.cancelLoading();
    if (result != null) {
      currencyList = result;
      await getCoinsType();
    }
  }

  Currency? userCurrency;

  getCoinsType() async {
    CustomLoading.showLoading();
    final userId = PreferenceUtils.getUserData()?.id;

    if (userId != null) {
      final result = await AuthRepository().getCoinsType(userId, "father");
      if (result != null) {
        userCurrency = result;
      }
    }

    CustomLoading.cancelLoading();
  }

  onRefresh() async {
    await getCurrency();
    if (currencyList.isNotEmpty) {
      await getCompanyTypes();
      await getCompanies(1);
      await getTop();
    }
  }

  getDataS() async {
    try {
      final response = await http.get(
        Uri.parse('https://admin.asas-app.com/api/companiesLocations'),
        headers: {
          'Host': "admin.asas-app.com",
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final jsonResponse = json.decode(response.body);

        // Access the 'companies' list
        mapList = jsonResponse['companies'];

        CustomLoading.cancelLoading();
        CustomLoading.showSuccessToast(msg: Strings.Added_successfully.tr);
      } else {
        CustomLoading.showLoading();
      }
    } catch (e) {
      print(" ERROR ::=====$e");
    }
  }

// Request location permissions
  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      // Location permissions granted
      enableMyLocation();
    }
  }

  // Enable the My Location layer
  var isMyLocationEnabled = false.obs; // Add this line
  void enableMyLocation() {
    isMyLocationEnabled.value = true; // Update the value using .value
  }

  BitmapDescriptor? customeMark;

  getBitMark() async {
    customeMark = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/images/iconic.png');
  }

  Set<Marker> createMarkers() {
    // Create a set to hold the markers
    Set<Marker> markers = {};

    cameraPosition = CameraPosition(
      target: LatLng(24.718513000000001511580194346606731414794921875,
          46.67437199999999819510776433162391185760498046875),
      zoom: 14,
      bearing: 10,
      tilt: 10,
    );

    try {
      for (var map in mapList) {
        double longitude = map['longitude'];
        double latitude = map['latitude'];
        int id = map['id'];
        String? logo = map['logo'];
        String? name = map['name_corporation_ar'];
        int? rate = map['rounded_rate'];
        rate ??= 0;
        logo ??= '';
        name ??= '';
        markers.add(
          Marker(
            markerId: MarkerId('$id'),
            position: LatLng(latitude, longitude),
            icon: customeMark!,
            onTap: () {
              customInfoWindowController.addInfoWindow!(
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 0.1),
                          color: Colors.amberAccent,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Get.toNamed(Routes.USER_CATEGORY_DETAILS,
                                arguments: [id]);
                          },
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      Constance.imageCompanyBaseUrl + logo!)),
                              SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                child: ListView(
                                  children: [
                                    Text(
                                      name!,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      ' التقييم : ${rate!}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Triangle.isosceles(
                      edge: Edge.BOTTOM,
                      child: Container(
                        color: Colors.amberAccent,
                        width: 20.0,
                        height: 10.0,
                      ),
                    ),
                  ],
                ),
                LatLng(latitude, longitude),
              );
            },
          ),
        );
      }
    } catch (e) {
      print('the err $e');
    }

    enableMyLocation();

    // Add more markers as needed
    this.markers = markers;

    return markers;
  }

  @override
  void onInit() {
    mapCompleter = Completer();
    getDataS();
    getBitMark();
    requestLocationPermission();
    customInfoWindowController = CustomInfoWindowController();
    OwnerSharedPref.init();
    companyScrollController.addListener(() {
      if (companyScrollController.position.atEdge) {
        bool isTop = companyScrollController.position.pixels == 0;
        if (!isTop) {
          getCompaniesNextPage();
        }
      }
    });
    onRefresh();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    companyScrollController.dispose();
    customInfoWindowController.dispose();
  }

  void openDrawer() {
    xOffset.value =
        PreferenceUtils.getCurrentLocale() == const Locale('en', 'US')
            ? Get.size.width * 0.70
            : -Get.size.width * 0.58;
    yOffset.value = 0;
    verticalMargin.value = 40;
    scaleFactor.value = 1;
    isDrawerOpen.value = true;
  }

  void closeDrawer() {
    if (isDrawerOpen.value) {
      xOffset.value = 0;
      yOffset.value = 0;
      verticalMargin.value = 0;
      scaleFactor.value = 1;
      isDrawerOpen.value = false;
    }
  }

  void toggleDrawer() {
    if (xOffset.value == 0) {
      openDrawer();
    } else {
      closeDrawer();
    }
  }

  Matrix4 getTransformValue() {
    return PreferenceUtils.getCurrentLocale() == const Locale('en', 'US')
        ? Matrix4.rotationY(22 / 7)
        : Matrix4.rotationY(0);
  }
}
