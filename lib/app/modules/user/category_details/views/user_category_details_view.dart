import 'package:asas/app/data/model/comment_response.dart';
import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/data/model/program.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/bottom_sheet.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/loading_widget.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/user_category_details_controller.dart';

class UserCategoryDetailsView extends GetView<UserCategoryDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserCategoryDetailsController>(
          id: "main",
          builder: (ctrl) {
            if (ctrl.company == null) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
            return NestedScrollView(
              controller: ScrollController(keepScrollOffset: true),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverCustomHeaderDelegate(
                          title: Get.locale.toString() == 'en_US'
                              ? controller.company!.owner!.nameCorporation!
                              : controller.company!.owner!.nameCorporationAr ??
                                  "-",
                          collapsedHeight: kToolbarHeight,
                          expandedHeight: 275,
                          paddingTop: MediaQuery.of(context).padding.top,
                          carouselChangeIndex: controller.carouselChangeIndex,
                          carouselImages: controller.carouselImages,
                          pageViewController: controller.pageViewController,
                          addFav: () => ctrl.addToFav(),
                          showFav: ctrl.showFavIcon,
                          deleteFromFav: () => ctrl.deleteFromFav(),
                          isFav: ctrl.company!.addToFav,
                          onShareClicked: () {}))
                ];
              },
              body: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Booster.verticalSpace(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Booster.textTitle(
                            context,
                            Get.locale.toString() == 'en_US'
                                ? controller.company!.owner!.nameCorporation!
                                : controller
                                        .company!.owner!.nameCorporationAr ??
                                    "-",
                            color: LightColors.TEXT_PRIMARY_COLOR),
                        GestureDetector(
                          onTap: () => ctrl.messaging(),
                          child: Container(
                            height: 35,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: LightColors.ACCENT_COLOR,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Booster.textBody(context, Strings.message.tr,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    textSize: 11),
                                Booster.horizontalSpace(5),
                                SvgPicture.asset('assets/svg/message.svg',
                                    color: Colors.white, width: 25),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Booster.verticalSpace(10),
                    // RatingBar.builder(
                    //   initialRating: ctrl.company!.rateTotal!.toDouble() / 2,
                    //   minRating: 1,
                    //   direction: Axis.horizontal,
                    //   allowHalfRating: false,
                    //   ignoreGestures: true,
                    //   itemSize: 20,
                    //   itemCount: 5,
                    //   itemPadding: EdgeInsets.symmetric(horizontal: 0),
                    //   itemBuilder: (context, _) => Icon(
                    //     Icons.star_rounded,
                    //     color: LightColors.ACCENT_COLOR,
                    //   ),
                    //   onRatingUpdate: (rating) {
                    //     print(rating);
                    //   },
                    // ),
                    Booster.verticalSpace(5),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    Booster.verticalSpace(5),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                          border:
                              Border.all(color: LightColors.EDIT_BORDER_COLOR)),
                      height: 45,
                      child: TabBar(
                        controller: controller.tabBarController,
                        physics: const NeverScrollableScrollPhysics(),
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              4.0,
                            ),
                            color: LightColors.PRIMARY_COLOR,
                            border: Border.all(
                                color: LightColors.PRIMARY_COLOR,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                style: BorderStyle.solid)),
                        labelColor: Colors.white,
                        unselectedLabelColor: LightColors.TEXT_HINT_COLOR,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                                fontWeight: FontWeight.normal, fontSize: 13),
                        tabs: [
                          Tab(
                            text: Strings.About_the_company.tr,
                          ),
                          Tab(
                            text: Strings.Packages.tr,
                          ),
                          Tab(
                            text: Strings.opinions.tr,
                          ),
                        ],
                      ),
                    ),
                    Booster.verticalSpace(10),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabBarController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          AboutCompany(),
                          Programs(),
                          Comments(
                            companyId: ctrl.company!.id!,
                            pushComment: (comment) {
                              ctrl.commentList.add(comment);
                              ctrl.commentStatus = ApiCallStatus.success;
                              ctrl.update(['comments']);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class AboutCompany extends StatelessWidget {
  const AboutCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserCategoryDetailsController>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Booster.textBody(
            context,
            controller.company!.desceptionAr!,
            color: LightColors.TEXT_PRIMARY_COLOR,
          ),
          Booster.verticalSpace(5),
          Divider(
            color: Colors.grey.withOpacity(0.5),
          ),
          Booster.verticalSpace(5),
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GoogleMap(
                mapType: MapType.normal,
                markers: controller.markers,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: false,
                liteModeEnabled: false,
                rotateGesturesEnabled: false,
                mapToolbarEnabled: false,
                indoorViewEnabled: false,
                onTap: (_) => controller.goToMap(),
                myLocationButtonEnabled: false,
                compassEnabled: false,
                // gestureRecognizers: {
                //   Factory<OneSequenceGestureRecognizer>(
                //       () => ScaleGestureRecognizer()),
                // },
                initialCameraPosition: controller.cameraPosition,
                onMapCreated: (GoogleMapController ctrl) async {
                  try {
                    controller.mapCompleter.complete(ctrl);
                    controller.googleMapController =
                        await controller.mapCompleter.future;
                    controller.googleMapController!.animateCamera(
                        CameraUpdate.newCameraPosition(
                            controller.cameraPosition));
                  } catch (e) {
                    Logger().e(e);
                  }
                },
                myLocationEnabled: true,
              ),
            ),
          ),
          Booster.verticalSpace(5),
          Divider(
            color: Colors.grey.withOpacity(0.5),
          ),
          Booster.verticalSpace(5),
          Booster.textTitle(context, Strings.Evaluation.tr,
              color: LightColors.PRIMARY_COLOR),
          Booster.verticalSpace(10),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: LightColors.ACCENT_COLOR, width: 1.5),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.01),
                      blurRadius: 5,
                      spreadRadius: 5)
                ]),
            child: Column(
              children: [
                RattingItem(
                    title: Strings.Scientific_level.tr,
                    value: controller.company!.rate!.scientificLevel!
                        .toStringAsFixed(1)),
                RattingItem(
                    title: Strings.activity_level.tr,
                    value: controller.company!.rate!.activityLevel!
                        .toStringAsFixed(1)),
                RattingItem(
                    title: Strings.Buildings_and_stadiums.tr,
                    value: controller.company!.rate!.buildingsAndStadiums!
                        .toStringAsFixed(1)),
                RattingItem(
                    title: Strings.Attention_and_communication.tr,
                    value: controller.company!.rate!.attentionAndCommunication!
                        .toStringAsFixed(1)),
                RattingItem(
                    title: Strings.Discipline_and_hygiene.tr,
                    value: controller.company!.rate!.disciplineAndCleanliness!
                        .toStringAsFixed(1)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Programs extends StatelessWidget {
  const Programs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserCategoryDetailsController>(
      id: 'programs',
      builder: (ctrl) {
        if (ctrl.programStatus == ApiCallStatus.success) {
          return RefreshIndicator(
            onRefresh: () => ctrl.getPrograms(1),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: ctrl.programScrollController,
                itemCount: ctrl.programList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => ProgramListItem(
                      program: ctrl.programList[index],
                      company: ctrl.company!,
                    )),
          );
        } else if (ctrl.programStatus == ApiCallStatus.loading) {
          return LoadingList(
            height: 75,
          );
        } else if (ctrl.programStatus == ApiCallStatus.failed) {
          return Center(child: Text(Strings.The_data_was_not_fetched.tr));
        } else {
          // ctrl.sectionsStatus == ApiCallStatus.empty
          return Center(child: Text(Strings.There_are_no_programs.tr));
        }
      },
    );
  }
}

class Comments extends StatelessWidget {
  final int companyId;
  final Function pushComment;

  const Comments({Key? key, required this.companyId, required this.pushComment})
      : super(key: key);

  addComment(int companyId, String comment) async {
    CustomLoading.showLoading();
    final result = await UserRepository().addComment(companyId, comment);
    if (result) {
      pushComment(Comment(
          fatherName: PreferenceUtils.getUserData()?.name ?? "",
          opinion: comment));
    }
    CustomLoading.cancelLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => BottomSheetUtils.showAddCommentBottomSheet(context,
              onSubmit: (String comment) {
            Get.back();

            BottomSheetUtils.showRattingBottomSheet(Get.context!,
                (r_1, r_2, r_3, r_4, r_5) async {
              if (r_1 == null ||
                  r_2 == null ||
                  r_3 == null ||
                  r_4 == null ||
                  r_5 == null) {
                CustomLoading.showWrongToast(
                    msg: Strings.All_values_must_be_set.tr);
                return;
              }

              CustomLoading.showLoading();
              final result = await UserRepository()
                  .addRate(companyId, r_1, r_2, r_3, r_4, r_5);
              CustomLoading.cancelLoading();
              if (result) {
                await addComment(companyId, comment);

                Get.back();
              }
            });
          }),
          borderRadius: BorderRadius.circular(8),
          child: Ink(
            decoration: BoxDecoration(
              color: LightColors.EDIT_BORDER_COLOR,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Ink(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: LightColors.PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: LightColors.TEXT_WHITE_COLOR)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.addComment.tr,
                        style: TextStyle(
                          color: LightColors.EDIT_BORDER_COLOR,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        "assets/svg/comment_icon.svg",
                        color: Colors.white,
                      )
                    ],
                  )),
            ),
          ),
        ),
        Expanded(
            child: GetBuilder<UserCategoryDetailsController>(
          id: 'comments',
          builder: (ctrl) {
            if (ctrl.commentStatus == ApiCallStatus.success) {
              return RefreshIndicator(
                onRefresh: () => ctrl.getComments(1),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: ctrl.commentScrollController,
                    itemCount: ctrl.commentList.length,
                    padding: EdgeInsets.only(top: 25),
                    itemBuilder: (context, index) => CommentItem(
                          comment: ctrl.commentList[index],
                        )),
              );
            } else if (ctrl.commentStatus == ApiCallStatus.loading) {
              return LoadingList(
                height: 75,
              );
            } else if (ctrl.commentStatus == ApiCallStatus.failed) {
              return Center(child: Text(Strings.The_data_was_not_fetched.tr));
            } else {
              // ctrl.sectionsStatus == ApiCallStatus.empty
              return Center(child: Text(Strings.No_opinions.tr));
            }
          },
        )),
      ],
    );
  }
}

class CommentItem extends StatelessWidget {
  final Comment comment;
  const CommentItem({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: LightColors.EDIT_BACKGROUND_COLOR,
          border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
          borderRadius: BorderRadius.circular(6)),
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
              Booster.horizontalSpace(10),
              Booster.textTitle(context, comment.fatherName!,
                  color: LightColors.TEXT_PRIMARY_COLOR)
            ],
          ),
          Booster.verticalSpace(10),
          Row(
            children:
                List.generate(MediaQuery.of(context).size.width ~/ 14, (index) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
              );
            }),
          ),
          Booster.verticalSpace(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.comment, color: LightColors.PRIMARY_COLOR),
              Booster.horizontalSpace(10),
              Expanded(
                  child: Booster.textBody(context, comment.opinion!,
                      color: LightColors.TEXT_PRIMARY_COLOR))
            ],
          ),
        ],
      ),
    );
  }
}

class ProgramListItem extends StatelessWidget {
  final Program program;
  final Company? company;

  const ProgramListItem({Key? key, required this.program, this.company})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? discount =
        (program.discount != null && program.discount!.isNotEmpty)
            ? program.discount![0].priceRateDiscount
            : program.price_rate_discount;
    return Container(
      decoration: BoxDecoration(
          color: LightColors.EDIT_BACKGROUND_COLOR,
          border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
          borderRadius: BorderRadius.circular(6)),
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Booster.textTitle(context, program.nameAr!,
              color: LightColors.PRIMARY_COLOR),
          Divider(
            color: Colors.grey.withOpacity(0.5),
          ),
          Booster.textBody(context, program.descriptionAr!,
              color: LightColors.TEXT_PRIMARY_COLOR,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.start),
          Divider(
            color: Colors.grey.withOpacity(0.5),
          ),
          SizedBox(
            height: 25,
            child: Booster.textBody(context, program.priceNoteAr!,
                color: LightColors.TEXT_PRIMARY_COLOR,
                textAlign: TextAlign.start),
          ),
          SizedBox(
            height: 25,
            child: Booster.textBody(context, program.ageConditionsAr!,
                color: LightColors.TEXT_PRIMARY_COLOR,
                textAlign: TextAlign.start),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
          ),
          if (discount != null)
            Wrap(
              children: [
                Booster.textBody(context,
                    "${Strings.Price_after_discount.tr} $discount% ${Strings.discount.tr}",
                    color: LightColors.ACCENT_COLOR2),
                Booster.horizontalSpace(5),
                Booster.textBody(
                  context,
                  (program.getPrice() -
                          (program.getPrice() * (int.parse(discount) / 100)))
                      .toStringAsFixed(2),
                  color: LightColors.PRIMARY_COLOR,
                  fontWeight: FontWeight.bold,
                  textSize: 15,
                ),
                Booster.horizontalSpace(5),
                Booster.textBody(context, program.getPrice().toStringAsFixed(2),
                    color: LightColors.TEXT_PRIMARY_COLOR, lineThrough: true),
                Booster.horizontalSpace(5),
                Booster.textBody(
                  context,
                  program.getCoinsNameAr(),
                  color: LightColors.TEXT_PRIMARY_COLOR,
                ),
              ],
            ),
          if (discount == null)
            Row(
              children: [
                Booster.textBody(context, Strings.price.tr,
                    color: LightColors.ACCENT_COLOR2),
                Booster.textBody(
                  context,
                  program.getPrice().toStringAsFixed(2),
                  color: LightColors.TEXT_PRIMARY_COLOR,
                ),
                Booster.horizontalSpace(5),
                Booster.textBody(
                  context,
                  program.getCoinsNameAr(),
                  color: LightColors.TEXT_PRIMARY_COLOR,
                ),
              ],
            ),
          Booster.verticalSpace(10),
          MyButton(
            title: Strings.more_details.tr,
            onTap: () => Get.toNamed(Routes.USER_PROGRAM_DETAILS,
                arguments: [program, company]),
          )
        ],
      ),
    );
  }
}

class RattingItem extends StatelessWidget {
  final String title;
  final String value;

  const RattingItem({Key? key, required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: LightColors.PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Booster.horizontalSpace(8),
                Booster.textBody(context, title,
                    color: LightColors.TEXT_PRIMARY_COLOR)
              ],
            ),
            Booster.textTitle(context, value, color: LightColors.PRIMARY_COLOR)
          ],
        ),
        Booster.verticalSpace(5),
        Divider(
          color: Colors.grey.withOpacity(0.5),
        ),
        Booster.verticalSpace(5),
      ],
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String title;
  final Function onShareClicked;
  final Function? addFav;
  final Function? deleteFromFav;
  final bool? showFav;
  final bool? isFav;
  final pageViewController;
  final Function carouselChangeIndex;
  final List<String> carouselImages;

  SliverCustomHeaderDelegate({
    required this.collapsedHeight,
    required this.expandedHeight,
    required this.paddingTop,
    required this.title,
    required this.carouselImages,
    required this.pageViewController,
    required this.onShareClicked,
    required this.carouselChangeIndex,
    this.addFav,
    this.showFav,
    this.isFav,
    this.deleteFromFav,
  });

  @override
  double get minExtent => collapsedHeight + paddingTop;

  @override
  double get maxExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return LightColors.PRIMARY_COLOR.withAlpha(alpha);
  }

  Color makeStickyHeaderAppBarColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha =
          (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
      return LightColors.PRIMARY_COLOR.withAlpha(alpha);
    }
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha =
          (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 255, 255, 255);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final ctrl = Get.find<ChaletController>();
    return Container(
      height: maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: <Widget>[
          PageView(
            controller: pageViewController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              carouselChangeIndex(index);
            },
            children: carouselImages.isNotEmpty
                ? carouselImages
                    .map(
                      (imageUrl) => ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(15)),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: imageUrl,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      const Center(
                                          child: CupertinoActivityIndicator()),
                              errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: LightColors.EDIT_BORDER_COLOR,
                                  ),
                                  child: Icon(
                                    Icons.error,
                                    color: LightColors.PRIMARY_COLOR,
                                  )),
                              fit: BoxFit.cover,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0, 0.7],
                                colors: [
                                  LightColors.PRIMARY_COLOR,
                                  Colors.transparent,
                                ],
                              )),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList()
                : [
                    CachedNetworkImage(
                      imageUrl: '',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
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
                      fit: BoxFit.cover,
                    ),
                  ],
          ),
          Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageViewController, // PageController
                count: carouselImages.isNotEmpty ? carouselImages.length : 1,
                effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: Colors.grey.withOpacity(0.65),
                    activeDotColor: LightColors.ACCENT_COLOR),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: makeStickyHeaderBgColor(shrinkOffset), // Background color
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: collapsedHeight,
                  color: makeStickyHeaderAppBarColor(shrinkOffset, false),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Get.locale.toString() != 'en_US'
                              ? Icons.arrow_back_rounded
                              : Icons.arrow_forward,
                          textDirection: Get.locale! == Locale("AR", "ar")
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          color: makeStickyHeaderTextColor(shrinkOffset, true),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: makeStickyHeaderTextColor(
                              shrinkOffset, false), // Title color
                        ),
                      ),
                      if (showFav!)
                        Visibility(
                          // visible: shrinkOffset + paddingTop + collapsedHeight <=
                          //     expandedHeight,
                          child: GestureDetector(
                            onTap: () => isFav! ? deleteFromFav!() : addFav!(),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        color:
                                            Color(0xff717171).withOpacity(0.13),
                                        offset: Offset(0, 0),
                                      )
                                    ]),
                                width: 46,
                                height: 46,
                                child: Icon(
                                  Icons.favorite,
                                  color:
                                      isFav! ? Colors.redAccent : Colors.white,
                                )),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
