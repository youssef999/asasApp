import 'dart:async';

import 'package:asas/app/data/model/comment_response.dart';
import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/data/model/program.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/dialog_utils.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../translations/strings_enum.dart';

class UserCategoryDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
// completer to help with map initializing and creating (map controller)
  Completer<GoogleMapController> mapCompleter = Completer();

  // map controller (to animate camera and update position)
  GoogleMapController? googleMapController;

  // default position when user first open map it will point to (gaza)
  // but it will be updated when we get user location via location service
  late CameraPosition cameraPosition;

  // marker for the current chalet location
  late Set<Marker> markers;

  late final PageController pageViewController;
  late TabController tabBarController;

  int carouselIndex = 0;
  List<String> carouselImages = [];

  // late Section section ;

  carouselChangeIndex(int index) {
    carouselIndex = index;
  }

  void launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  Company? company;
  // Rating? rating;

  addToFav() async {
    final result = await UserRepository().addFavorite(company!.id!);
    if (result != null) {
      company!.addToFav = true;
      company!.favoriteId = result;
      update(['main']);
    }
  }

  deleteFromFav() async {
    final result = await UserRepository().deleteFavorite(company!.favoriteId!);
    if (result) {
      company!.addToFav = false;
      update(['main']);
    }
  }

  ///
  List<Comment> commentList = [];
  ScrollController commentScrollController = ScrollController();
  int commentTotalPages = 0;
  int commentCurrentPage = 1;
  ApiCallStatus commentStatus = ApiCallStatus.loading;

  ///

  ///
  List<Program> programList = [];
  ScrollController programScrollController = ScrollController();
  int programTotalPages = 0;
  int programCurrentPage = 1;
  ApiCallStatus programStatus = ApiCallStatus.loading;

  ///

  messaging() {
    if (!PreferenceUtils.getUserIsLogged()) {
      DialogUtils.showConfirmDialog(Get.context!,
          title: Strings.You_are_not_logged_in.tr,
          body: Strings.You_must_be_logged.tr,
          isDelete: false,
          textButton: Strings.LOGIN.tr, onConfirm: () {
        Get.back();
        Get.toNamed(Routes.LOGIN);
      });
      return;
    }
    Get.toNamed(Routes.SHARED_CHATE, arguments: [
      2,
      company?.id ?? 0,
      company?.owner?.nameCorporation ?? "..."
    ]);
  }

  /// if From Owner
  getDataForOwner() async {
    final result = await PortalRepository().getMyCompany();
    if (result != null) {
      company = result;
    }
    setData();
  }

  // getRating() async {
  //   final result = await UserRepository().getCompanyRate(company!.id!);
  //   rating = result;
  //   update(['rating']);
  // }

  getPrograms(int page) async {
    if (page == 1) {
      programStatus = ApiCallStatus.loading;
      update(['programs']);
      print('basx1');
    } else {
      CustomLoading.showLoading(msg: Strings.load_more.tr);
      print('basx2');
    }
    final userId = company!.owner!.id;
    if (userId == null) {
      print('basx3');
      return;
    }
    final data = await PortalRepository().getPrograms(userId, page);
    print('basx$data');
    print('basxx$userId');
    print('basxxx$page');
    if (page != 1) {
      print('basx5');
      CustomLoading.cancelLoading();
    }

    if (data != null && data.programs!.isNotEmpty) {
      print('basx6');
      programStatus = ApiCallStatus.success;

      if (page == 1) {
        print('basx7');
        programList = data.programs!;
      } else {
        print('basx8');
        if (data.programs!.isNotEmpty) {
          for (var element in data.programs!) {
            if (element.idTypeProgram == "1") {
              programList.add(element);
            }
          }
          programList.addAll(data.programs!);
          _animateToOffset(programScrollController.offset + (75 * 2));
        }
      }
      print('basx9');
      programTotalPages = data.lastPage!;
      programCurrentPage = data.currentPage!;
    } else if (data != null && data.programs!.isEmpty) {
      print('basx10');
      programStatus = ApiCallStatus.empty;
    } else {
      print('basx11');
      programStatus = ApiCallStatus.failed;
    }
    print('basx12');
    update(['programs']);
  }

  getComments(int page) async {
    if (page == 1) {
      commentStatus = ApiCallStatus.loading;
      update(['comments']);
    } else {
      CustomLoading.showLoading(msg: Strings.load_more.tr);
    }
    final userId = company!.owner!.id;
    if (userId == null) {
      return;
    }
    final data = await UserRepository().getComments(userId, page);

    if (page != 1) {
      CustomLoading.cancelLoading();
    }

    if (data != null && data.comments!.isNotEmpty) {
      commentStatus = ApiCallStatus.success;

      if (page == 1) {
        commentList = data.comments!;
      } else {
        if (data.comments!.isNotEmpty) {
          commentList.addAll(data.comments!);
          _animateToOffsetComments(commentScrollController.offset + (75 * 2));
        }
      }

      commentTotalPages = data.lastPage!;
      commentCurrentPage = data.currentPage!;
    } else if (data != null && data.comments!.isEmpty) {
      commentStatus = ApiCallStatus.empty;
    } else {
      commentStatus = ApiCallStatus.failed;
    }
    update(['comments']);
  }

  void _animateToOffset(double offset) {
    programScrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _animateToOffsetComments(double offset) {
    commentScrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  getCommentsNextPage() {
    if (commentCurrentPage < commentTotalPages) {
      getPrograms(commentCurrentPage + 1);
    }
  }

  getProgramsNextPage() {
    if (programCurrentPage < programTotalPages) {
      getPrograms(programCurrentPage + 1);
    }
  }

  goToMap() {
    Get.toNamed(Routes.SHARED_MAP, arguments: [company]);
  }

  setData() async {
    if (company == null) {
      CustomLoading.showWrongToast(msg: Strings.error_occurred.tr);
      return;
    }

    final String latitude = company!.lat == '-' ? "31.343812" : company!.lat!;
    final String longitude = company!.lng == '-' ? "34.314157" : company!.lng!;

    markers = <Marker>{
      Marker(
        markerId: MarkerId('chalet_location'),
        position: LatLng(
          double.parse(latitude),
          double.parse(longitude),
        ),
      )
    };

    cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(latitude),
          double.parse(longitude),
        ),
        zoom: 15);

    carouselImages = company!.media!
        .map((e) => Constance.imageCompanyBaseUrl + e.media!)
        .toList();

    update(['main']);

    // await getRating();
    await getPrograms(programCurrentPage);
    await getComments(commentCurrentPage);
  }

  getCompanyById(int id) async {
    int? fatherId = PreferenceUtils.getUserData()?.id;
    Company? result;

    if (fatherId != null) {
      showFavIcon = true;
      result = await UserRepository().getCompanyByIdWithFav(id, fatherId);
    } else {
      result = await UserRepository().getCompanyById(id);
    }

    if (result != null) {
      company = result;
    }
    setData();
  }

  bool showFavIcon = false;

  onRefresh() async {}

  @override
  void onInit() {
    super.onInit();

    final data = Get.arguments[0];

    if (data is String && data == 'FromOwner') {
      getDataForOwner();
    } else {
      getCompanyById(data);
    }

    pageViewController = PageController(initialPage: 0);
    tabBarController = TabController(length: 3, vsync: this);

    commentScrollController.addListener(() {
      if (commentScrollController.position.atEdge) {
        bool isTop = commentScrollController.position.pixels == 0;
        if (!isTop) {
          getProgramsNextPage();
        }
      }
    });

    programScrollController.addListener(() {
      if (programScrollController.position.atEdge) {
        bool isTop = programScrollController.position.pixels == 0;
        if (!isTop) {
          getProgramsNextPage();
          // getCommentsNextPage();
        }
      }
    });
    update();
  }

  @override
  void onClose() {
    pageViewController.dispose();
    tabBarController.dispose();
    commentScrollController.dispose();
    programScrollController.dispose();
    try {
      googleMapController?.dispose();
    } catch (error) {}
    super.onClose();
  }
}
