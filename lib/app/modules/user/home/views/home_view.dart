import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/owner_shared_pref.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:asas/app/modules/user/home/controllers/home_controller.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../helpers/dialog_utils.dart';
import '../../../../translations/strings_enum.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () => controller.closeDrawer(),
          onPanStart: (details) {
            controller.toggleDrawer();
          },
          child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.verticalMargin.value),
              transform: Matrix4.translationValues(
                  controller.xOffset.value, controller.yOffset.value, 0)
                ..scale(controller.scaleFactor.value)
                ..rotateY(controller.isDrawerOpen.value ? -0.5 : 0),
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      controller.isDrawerOpen.value ? 40 : 0.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    controller.isDrawerOpen.value ? 40 : 0.0),
                child: GetBuilder<HomeController>(
                    id: "HomeBuilder",
                    builder: (_) {
                      return Scaffold(
                        body: Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 145,
                                  margin: EdgeInsets.only(bottom: 22.5),
                                  decoration: BoxDecoration(
                                      color: LightColors.PRIMARY_COLOR,
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(10))),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  right:
                                      MediaQuery.of(context).size.width * 0.32,
                                  left: 0,
                                  child: SvgPicture.asset(
                                    "assets/svg/appbar_zaz.svg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  top: MediaQuery.of(context).padding.top + 10,
                                  right: 20,
                                  left: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: LightColors.ACCENT_COLOR,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: controller.isDrawerOpen()
                                            ? IconButton(
                                                icon: const Icon(
                                                  Icons.arrow_back_ios,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                onPressed: () {
                                                  controller.closeDrawer();
                                                },
                                              )
                                            : GestureDetector(
                                                onTap: () =>
                                                    controller.openDrawer(),
                                                child: Transform(
                                                  alignment: Alignment.center,
                                                  transform: controller
                                                      .getTransformValue(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/drawer_icon.svg',
                                                    ),
                                                  ),
                                                )),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (OwnerSharedPref
                                                  .getUserIsLogged()) {
                                                Get.offAllNamed(
                                                    Routes.OWNER_BASE_DRAWER);
                                                CustomLoading.showInfoToast(
                                                    msg: Strings
                                                        .Transferred_owner_status
                                                        .tr);
                                              } else if (OwnerSharedPref
                                                  .getIntroShow()) {
                                                Get.offAllNamed(
                                                    Routes.OWNER_LOGIN);
                                                CustomLoading.showInfoToast(
                                                    msg: Strings
                                                        .Transferred_owner_status
                                                        .tr);
                                              } else {
                                                Get.toNamed(
                                                    Routes.OWNER_SPLASH);
                                              }
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 105,
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                  color:
                                                      LightColors.ACCENT_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Booster.textBody(
                                                      context,
                                                      Strings
                                                          .owner_of_a_facility
                                                          .tr,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      textSize: 11),
                                                  SvgPicture.asset(
                                                      'assets/svg/convert.svg',
                                                      color: Colors.white,
                                                      width: 25),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.8,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      child: Stack(
                                                        children: [
                                                          GoogleMap(
                                                            cameraTargetBounds:
                                                                CameraTargetBounds
                                                                    .unbounded,
                                                            fortyFiveDegreeImageryEnabled:
                                                                true,
                                                            indoorViewEnabled:
                                                                true,
                                                            trafficEnabled:
                                                                true,
                                                            mapType:
                                                                MapType.normal,
                                                            markers: controller
                                                                .createMarkers(),
                                                            zoomControlsEnabled:
                                                                true,
                                                            zoomGesturesEnabled:
                                                                true,
                                                            myLocationButtonEnabled:
                                                                true,
                                                            compassEnabled:
                                                                true,
                                                            initialCameraPosition:
                                                                controller
                                                                    .cameraPosition,
                                                            onMapCreated:
                                                                (GoogleMapController
                                                                    ctrl) async {
                                                              controller
                                                                  .mapCompleter
                                                                  .complete(
                                                                      ctrl);
                                                              controller
                                                                      .googleMapController =
                                                                  await controller
                                                                      .mapCompleter
                                                                      .future;
                                                              controller
                                                                  .googleMapController!
                                                                  .animateCamera(
                                                                      CameraUpdate
                                                                          .newCameraPosition(
                                                                controller
                                                                    .cameraPosition,
                                                              ));
                                                              controller
                                                                  .customInfoWindowController
                                                                  .googleMapController = ctrl;
                                                            },
                                                            myLocationEnabled:
                                                                true,
                                                            onTap: (position) {
                                                              // Hide the info window when tapping the map
                                                              controller
                                                                  .customInfoWindowController
                                                                  .hideInfoWindow!();
                                                            },
                                                            onCameraMove:
                                                                (position) {
                                                              controller
                                                                  .customInfoWindowController
                                                                  .onCameraMove!();
                                                            },
                                                          ),
                                                          CustomInfoWindow(
                                                            controller: controller
                                                                .customInfoWindowController,
                                                            height: 75,
                                                            width: 150,
                                                            offset: 35,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                color: LightColors.ACCENT_COLOR,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (!PreferenceUtils
                                                  .getUserIsLogged()) {
                                                DialogUtils.showConfirmDialog(
                                                    Get.context!,
                                                    title: Strings
                                                        .You_are_not_logged_in
                                                        .tr,
                                                    body: Strings
                                                        .You_must_be_logged.tr,
                                                    isDelete: false,
                                                    textButton: Strings.Login
                                                        .tr, onConfirm: () {
                                                  Get.back();
                                                  Get.toNamed(Routes.LOGIN);
                                                });
                                                return;
                                              }
                                              Get.toNamed(Routes.NOTIFICATION);
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                  color:
                                                      LightColors.ACCENT_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Icon(
                                                Icons.notifications,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 20,
                                  right: 20,
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 3,
                                          blurRadius: 8,
                                          offset: const Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () => Get.toNamed(Routes.SEARCH),
                                      child: AbsorbPointer(
                                        child: Container(
                                          height: 45,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Booster.textBody(
                                                      context,
                                                      Strings
                                                          .Enter_keywords.tr.tr,
                                                      textSize: 14,
                                                      color: LightColors
                                                          .TEXT_HINT_COLOR)
                                                ],
                                              ),
                                              Container(
                                                height: 35,
                                                width: 35,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                    color: LightColors
                                                        .ACCENT_COLOR,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: SvgPicture.asset(
                                                  'assets/svg/search_icon.svg',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () => controller.onRefresh(),
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(
                                          parent:
                                              AlwaysScrollableScrollPhysics()),
                                      child: Container(
                                        padding: EdgeInsets.only(top: 25),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child:
                                                    GetBuilder<HomeController>(
                                                  id: 'companyTypes',
                                                  builder: (ctrl) {
                                                    if (ctrl.companyTypesStatus ==
                                                        ApiCallStatus.loading) {
                                                      return SizedBox(
                                                        height: 60,
                                                        child: LoadingList(
                                                          height: 55,
                                                          width: 55,
                                                          margin: 0,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          count: 5,
                                                        ),
                                                      );
                                                    } else if (ctrl
                                                            .companyTypesStatus ==
                                                        ApiCallStatus.success) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          ...ctrl
                                                              .companyTypeList
                                                              .map(
                                                            (e) =>
                                                                CategoryListItem(
                                                              onClicked: () =>
                                                                  Get.toNamed(
                                                                      Routes
                                                                          .USER_CATEGORY,
                                                                      arguments: [
                                                                    e.id,
                                                                    e.typeNameAr
                                                                  ]),
                                                              title:
                                                                  e.typeNameAr!,
                                                              icon: Constance
                                                                      .imageCompanyTypeBaseUrl +
                                                                  e.icon!,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    } else if (ctrl
                                                            .companyTypesStatus ==
                                                        ApiCallStatus.empty) {
                                                      return Center(
                                                        child: Booster.textTitle(
                                                            context,
                                                            Strings
                                                                .There_are_no_types
                                                                .tr),
                                                      );
                                                    } else {
                                                      return Center(
                                                        child: Booster.textTitle(
                                                            context,
                                                            Strings
                                                                .Download_failed
                                                                .tr),
                                                      );
                                                    }
                                                  },
                                                )),
                                            Booster.verticalSpace(25),
                                            Container(
                                              color: LightColors
                                                  .EDIT_BACKGROUND_COLOR,
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GetBuilder<HomeController>(
                                                      id: "topCompany",
                                                      builder: (ctrl) {
                                                        if (ctrl.topCompanyStatus ==
                                                            ApiCallStatus
                                                                .success) {
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .only(
                                                                        start:
                                                                            20),
                                                                child: Booster
                                                                    .textSecondaryTitle(
                                                                        context,
                                                                        Strings
                                                                            .The_best_offers_in_your_city
                                                                            .tr),
                                                              ),
                                                              Booster
                                                                  .verticalSpace(
                                                                      10),
                                                              SizedBox(
                                                                height: 120,
                                                                child: ListView
                                                                    .builder(
                                                                        scrollDirection: Axis
                                                                            .horizontal,
                                                                        padding: EdgeInsetsDirectional.only(
                                                                            start:
                                                                                20),
                                                                        physics:
                                                                            const BouncingScrollPhysics(),
                                                                        itemCount: ctrl
                                                                            .topCompanyList
                                                                            .length,
                                                                        itemBuilder: (context,
                                                                                index) =>
                                                                            BestOffersListItem(
                                                                              company: ctrl.topCompanyList[index],
                                                                            )),
                                                              ),
                                                            ],
                                                          );
                                                        } else if (ctrl
                                                                .topCompanyStatus ==
                                                            ApiCallStatus
                                                                .loading) {
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .only(
                                                                        start:
                                                                            20),
                                                                child: Booster
                                                                    .textSecondaryTitle(
                                                                        context,
                                                                        Strings
                                                                            .The_best_offers_in_your_city
                                                                            .tr),
                                                              ),
                                                              Booster
                                                                  .verticalSpace(
                                                                      10),
                                                              SizedBox(
                                                                height: 120,
                                                                child:
                                                                    LoadingList(
                                                                  height: 75,
                                                                  width: 150,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        } else if (ctrl
                                                                .topCompanyStatus ==
                                                            ApiCallStatus
                                                                .failed) {
                                                          return const SizedBox();
                                                        } else {
                                                          // ctrl.sectionsStatus == ApiCallStatus.empty
                                                          return const SizedBox();
                                                        }
                                                      })
                                                ],
                                              ),
                                            ),
                                            Booster.verticalSpace(10),
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      start: 20),
                                              child: Booster.textSecondaryTitle(
                                                  context,
                                                  Strings
                                                      .Educational_institutions_city
                                                      .tr),
                                            ),
                                            Booster.verticalSpace(10),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GetBuilder<HomeController>(
                                        builder: (ctrl) {
                                          if (ctrl.companyStatus ==
                                              ApiCallStatus.success) {
                                            return ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                controller: controller
                                                    .companyScrollController,
                                                itemCount:
                                                    ctrl.companyList.length,
                                                shrinkWrap: true,
                                                primary: false,
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index) =>
                                                    InYourCityListItem(
                                                      company: ctrl
                                                          .companyList[index],
                                                    ));
                                          } else if (ctrl.companyStatus ==
                                              ApiCallStatus.loading) {
                                            return LoadingList(
                                              height: 75,
                                            );
                                          } else if (ctrl.companyStatus ==
                                              ApiCallStatus.failed) {
                                            return Center(
                                                child: Text(Strings
                                                    .The_data_was_not_fetched
                                                    .tr));
                                          } else {
                                            // ctrl.sectionsStatus == ApiCallStatus.empty
                                            return Center(
                                                child: Text(Strings
                                                    .There_are_institutions
                                                    .tr));
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )),
        ));
  }
}

class InYourCityListItem extends StatelessWidget {
  final Company company;
  const InYourCityListItem({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.USER_CATEGORY_DETAILS, arguments: [company.id]),
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 110.0,
        decoration: BoxDecoration(
            border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: Constance.imageCompanyBaseUrl + company.logo!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const Center(child: CupertinoActivityIndicator()),
                  errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: LightColors.EDIT_BORDER_COLOR,
                      ),
                      child: Icon(
                        Icons.error,
                        color: LightColors.PRIMARY_COLOR,
                      )),
                  // width: 80,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Booster.textSecondaryTitle(
                      context,
                      company.nameCorporation ??
                          company.owner?.nameCorporation ??
                          "-",
                    ),
                    RatingBar.builder(
                      initialRating: (company.rateTotal ?? 0).toDouble() / 2,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      ignoreGestures: true,
                      itemSize: 20,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0),
                      unratedColor: Colors.black.withOpacity(0.5),
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rounded,
                        color: LightColors.ACCENT_COLOR,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                     Booster.textBody(context, company.desceptionAr!,
                          withHeight: false, textSize: 11),
                    
                    // Booster.textBody(context, "تبعد 5كم عن وسط المدينة", )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BestOffersListItem extends StatelessWidget {
  final Company company;
  const BestOffersListItem({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.USER_CATEGORY_DETAILS, arguments: [company.id]),
      child: Row(
        children: [
          Container(
              height: 120,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(7.0),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      Constance.imageCompanyBaseUrl + company.logo!,
                    ),
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            LightColors.PRIMARY_COLOR.withOpacity(0.8)
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.0, 0.95),
                          stops: const [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                  Positioned.directional(
                    height: 25,
                    end: 10,
                    top: 10,
                    textDirection:
                        PreferenceUtils.getCurrentLocale() == Locale('ar', 'AR')
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                    child: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: LightColors.ACCENT_COLOR,
                          borderRadius: BorderRadius.circular(3)),
                      child: Booster.textBody(
                        context,
                        'TOP 10',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned.directional(
                    start: 10,
                    bottom: 10,
                    textDirection:
                        PreferenceUtils.getCurrentLocale() == Locale('ar', 'AR')
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Booster.textBody(
                          context,
                          company.nameCorporation ?? "-",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        RatingBar.builder(
                          initialRating: company.rateTotal!.toDouble() / 2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          ignoreGestures: true,
                          itemSize: 20,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star_rounded,
                            color: LightColors.ACCENT_COLOR,
                          ),
                          unratedColor: Colors.white.withOpacity(0.5),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Booster.horizontalSpace(10),
        ],
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final String icon;
  final String title;
  final Function onClicked;
  const CategoryListItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked(),
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      offset: Offset(0, 0),
                      blurRadius: 8,
                      spreadRadius: 2)
                ]),
            child: SvgPicture.network(icon),
          ),
          SizedBox(
            height: 5,
          ),
          Booster.textBody(context, title, textSize: 11)
        ],
      ),
    );
  }
}
