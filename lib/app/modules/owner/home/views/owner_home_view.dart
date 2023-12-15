import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/owner_home_controller.dart';

class OwnerHomeView extends GetView<OwnerHomeController> {
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
                child: GetBuilder<OwnerHomeController>(
                    id: "HomeBuilder",
                    builder: (_) {
                      return Scaffold(
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 155,
                                  decoration: BoxDecoration(
                                      color: LightColors.PRIMARY_COLOR,
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(10))),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  right:
                                      MediaQuery.of(context).size.width * 0.25,
                                  left: 0,
                                  child: SvgPicture.asset(
                                    "assets/svg/appbar_zaz.svg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                    bottom: 12,
                                    right: 25,
                                    left: 25,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Booster.textTitle(
                                            context, Strings.welcome_our_partner.tr,
                                            color: Colors.white),
                                        Booster.textBody(
                                            context, Strings.basic_application.tr,
                                            color: Colors.white, textSize: 11),
                                      ],
                                    )),
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
                                              Get.offAllNamed(
                                                  Routes.BASE_DRAWER);
                                              CustomLoading.showInfoToast(
                                                  msg:
                                                  Strings.Switched_to_user_mode.tr);
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
                                              child: SvgPicture.asset(
                                                'assets/svg/convert.svg',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: ()=> Get.toNamed(Routes.OWNER_NOTIFICATION),
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
                              ],
                            ),
                            Expanded(
                              child: GridView(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 25),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15,
                                        childAspectRatio: 1.2,
                                        crossAxisSpacing: 15),
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                children: <Widget>[
                                  ListItem(
                                    image: 'assets/svg/owner/org_data.svg',
                                    title: Strings.Enterprise_data.tr,
                                    onClick: () => Get.toNamed(Routes.OWNER_ORG_DATA),
                                  ),
                                  ListItem(
                                    image: 'assets/svg/owner/program_list.svg',
                                    title: Strings.Program_List.tr,
                                    onClick: () => Get.toNamed(Routes.OWNER_PROGRAMS),
                                  ),
                                  ListItem(
                                    image: 'assets/svg/owner/book_request.svg',
                                    title: Strings.Booking_requests.tr,
                                    onClick: () => Get.toNamed(
                                        Routes.OWNER_BOOKING_REQUSETS),
                                  ),
                                  ListItem(
                                      image: 'assets/svg/owner/user_view.svg',
                                      title: Strings.User_preview.tr,
                                      onClick: () => Get.toNamed(Routes.USER_CATEGORY_DETAILS, arguments: ["FromOwner"]),
                                  ),
                                  ListItem(
                                      image: 'assets/svg/owner/agreements.svg',
                                      title: Strings.conventions.tr,
                                      onClick: () => Get.toNamed(Routes.OWNER_AGREEMENT),),
                                  ListItem(
                                    image: 'assets/svg/owner/settings.svg',
                                    title: Strings.General_Settings.tr,
                                    onClick: () =>
                                        Get.toNamed(Routes.OWNER_SETTINGS),
                                  ),
                                ],
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

class ListItem extends StatelessWidget {
  final String image;
  final String title;
  final Function? onClick;

  const ListItem(
      {Key? key, required this.title, required this.image, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick == null ? () {} : onClick!();
      },
      borderRadius: BorderRadius.circular(13),
      child: Ink(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  offset: Offset(0, 0),
                  blurRadius: 8,
                  spreadRadius: 2)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image),
            Booster.verticalSpace(15),
            Booster.textTitle(context, title, color: LightColors.PRIMARY_COLOR)
          ],
        ),
      ),
    );
  }
}
