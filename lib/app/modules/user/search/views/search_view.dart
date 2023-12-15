import 'package:asas/app/data/model/company.dart';
import 'package:asas/app/helpers/bottom_sheet.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/modules/user/category_details/views/user_category_details_view.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchControllerV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.search.tr),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      6.0,
                    ),
                    border: Border.all(color: LightColors.EDIT_BORDER_COLOR)),
                height: 45,
                child: TabBar(
                  controller: controller.tabBarController,
                  physics: const NeverScrollableScrollPhysics(),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    color: LightColors.PRIMARY_COLOR,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: LightColors.TEXT_HINT_COLOR,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontWeight: FontWeight.normal, fontSize: 13),
                  tabs: [
                    Tab(
                      text: Strings.Institutions.tr,
                    ),
                    Tab(
                      text: Strings.Programs.tr,
                    ),
                  ],
                ),
              ),
              Booster.verticalSpace(15),
              // Booster.horizontalSpace(8),
              // FilterBox(),
              Expanded(
                child: TabBarView(
                  controller: controller.tabBarController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Column(
                      children: [
                        SearchBox(
                          textEditingController: controller.searchController,
                          onTap: () => BottomSheetUtils.showSortBottomSheet(
                              context,
                              controller.actionId ?? 1,
                              (actionId) =>
                                  controller.filter(context, actionId!, 1)),
                        ),
                        Booster.verticalSpace(10),
                        Expanded(
                          child: GetBuilder<SearchControllerV>(
                            id: 'company',
                            builder: (ctrl) {
                              if (ctrl.companyStatus == ApiCallStatus.success) {
                                return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    controller:
                                        controller.companyScrollController,
                                    itemCount: ctrl.companyList.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) => ListItem(
                                          company: ctrl.companyList[index],
                                          type: ctrl.getTypeName(ctrl
                                              .companyList[index]
                                              .idCompanyType!),
                                        ));
                              } else if (ctrl.companyStatus ==
                                  ApiCallStatus.loading) {
                                return LoadingList(
                                  height: 75,
                                );
                              } else if (ctrl.companyStatus ==
                                  ApiCallStatus.failed) {
                                return Center(
                                    child: Text(
                                        Strings.The_data_was_not_fetched.tr));
                              } else {
                                // ctrl.sectionsStatus == ApiCallStatus.empty
                                return Center(
                                    child: Text(
                                        Strings.There_are_institutions.tr));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GetBuilder<SearchControllerV>(
                            id: 'program',
                            builder: (ctrl) {
                              return CustomSearchableDropDown(
                                items: ctrl.programTypeList,
                                label: Strings.Program_type.tr,
                                decoration: BoxDecoration(
                                    color: LightColors.EDIT_BACKGROUND_COLOR,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: LightColors.EDIT_BORDER_COLOR)),
                                suffixIcon: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                ),
                                prefixIcon: SizedBox(),
                                labelStyle: TextStyle(
                                    color: LightColors.TEXT_PRIMARY_COLOR,
                                    fontSize: 14),
                                dropDownMenuItems: ctrl.programTypeList
                                    .map((e) => e.programTypeAr)
                                    .toList(),
                                hint: Strings.Program_type.tr,
                                dropdownHintText: Strings.Program_type.tr,
                                onChanged: (value) {
                                  //id_typeProgram
                                  if (value == null) {
                                    return;
                                  }
                                  ctrl.setProgramType(value.id);
                                },
                              );
                            }),
                        Booster.verticalSpace(10),
                        ProgramSearchBox(
                          textEditingController:
                              controller.programSearchController,
                          onTap: () => BottomSheetUtils.showSortBottomSheet(
                              context,
                              controller.actionId ?? 1,
                              (actionId) =>
                                  controller.filter(context, actionId!, 1)),
                        ),
                        Booster.verticalSpace(10),
                        Expanded(
                          child: GetBuilder<SearchControllerV>(
                            id: 'programList',
                            builder: (ctrl) {
                              if (ctrl.programStatus == ApiCallStatus.success) {
                                return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    controller:
                                        controller.programScrollController,
                                    itemCount: ctrl.programList.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) =>
                                        ProgramListItem(
                                          program: ctrl.programList[index],
                                        ));
                              } else if (ctrl.programStatus ==
                                  ApiCallStatus.holding) {
                                return Center(
                                    child: Text(
                                        Strings.Choose_the_type_program.tr));
                              } else if (ctrl.programStatus ==
                                  ApiCallStatus.loading) {
                                return LoadingList(
                                  height: 75,
                                );
                              } else if (ctrl.programStatus ==
                                  ApiCallStatus.failed) {
                                return Center(
                                    child: Text(
                                        Strings.The_data_was_not_fetched.tr));
                              } else {
                                // ctrl.sectionsStatus == ApiCallStatus.empty
                                return Center(
                                    child:
                                        Text(Strings.There_are_no_programs.tr));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: ButtonSort(
          onTap: () => BottomSheetUtils.showSortBottomSheet(
              context,
              controller.actionId ?? 1,
              (actionId) => controller.filter(context, actionId!, 1)),
          onTapV: () => BottomSheetUtils.showSortBottomSheetV(
              context,
              controller.actionId ?? 1,
              (actionId) => controller.filter(context, actionId!, 1)),
        ));
  }
}

// class FilterBox extends StatelessWidget {
//   const FilterBox({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: ()=> BottomSheetUtils.showSortBottomSheet(context, (actionId) {
//
//       }),
//       borderRadius: BorderRadius.circular(8),
//       child: Ink(
//         height: 50,
//         width: 50,
//         decoration: BoxDecoration(
//           color: LightColors.PRIMARY_COLOR,
//           borderRadius: BorderRadius.circular(8)
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Booster.textBody(context, "ترتيب حسب", color: Colors.white, textSize: 13),
//             // Booster.horizontalSpace(7),
//             SvgPicture.asset("assets/svg/sort.svg")
//           ],
//         ),
//       ),
//     );
//     // Booster.horizontalSpace(7),
//     // Expanded(
//     //   child: InkWell(
//     //     onTap: ()=> BottomSheetUtils.showFilterBottomSheet(context, (actionId) {
//     //
//     //
//     //     }),
//     //     borderRadius: BorderRadius.circular(8),
//     //     child: Ink(
//     //       height: 36,
//     //       decoration: BoxDecoration(
//     //           color: LightColors.PRIMARY_COLOR,
//     //           borderRadius: BorderRadius.circular(8)
//     //       ),
//     //       child: Row(
//     //         mainAxisAlignment: MainAxisAlignment.center,
//     //         children: [
//     //           Booster.textBody(context, "تصنيف حسب", color: Colors.white, textSize: 13),
//     //           Booster.horizontalSpace(7),
//     //           SvgPicture.asset("assets/svg/filter.svg")
//     //         ],
//     //       ),
//     //     ),
//     //   ),
//     // ),
//   }
// }

class ProgramSearchBox extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function onTap;
  const ProgramSearchBox(
      {Key? key, required this.textEditingController, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      controller: textEditingController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      style: Theme.of(context)
          .textTheme
          .bodyText1
          ?.copyWith(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 35,
                width: 35,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: LightColors.ACCENT_COLOR,
                    borderRadius: BorderRadius.circular(5)),
                child: SvgPicture.asset(
                  'assets/svg/search_icon.svg',
                ),
              ),

              // GestureDetector(
              //   onTap: ()=> onTap(),
              //   child: Container(
              //     height: 35,
              //     width: 35,
              //     //padding: const EdgeInsets.all(8.0),
              //     margin: const EdgeInsets.all(8.0),
              //     decoration: BoxDecoration(
              //         color: LightColors.PRIMARY_COLOR,
              //         borderRadius: BorderRadius.circular(5)
              //     ),
              //     child: Icon(Icons.all_inbox_rounded, color: Colors.white,),
              //   ),
              // ),
            ],
          ),
          errorStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.redAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: Strings.Search_by_keyword.tr,
          hintStyle:
              TextStyle(color: LightColors.TEXT_HINT_COLOR, fontSize: 14.0),
          filled: true,
          fillColor: LightColors.EDIT_BACKGROUND_COLOR,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: LightColors.EDIT_BORDER_FOCUSED_COLOR),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            //borderSide: BorderSide(color: Colors.white),
            borderSide: BorderSide(color: Colors.grey[300]!),
          )),
    );
  }
}

class ButtonSort extends StatelessWidget {
  final Function? onTap;
  final Function? onTapV;
  const ButtonSort({Key? key, this.onTap, this.onTapV}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () => onTap!(),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 8, right: 10, top: 8, bottom: 5),
                decoration: BoxDecoration(
                    color: LightColors.PRIMARY_COLOR,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Row(
                  children: [
                    Text(
                      Strings.filter.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    SizedBox(
                      width: 2.9,
                    ),
                    SvgPicture.asset(
                      'assets/svg/filter.svg',
                      matchTextDirection: true,
                      width: 13,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 30,
              width: 1,
              color: Color.fromARGB(255, 25, 129, 163),
              child: Divider(
                thickness: 20,
                color: Colors.amberAccent,
              ),
            ),
            GestureDetector(
              onTap: () => onTapV!(),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 8, right: 10, top: 8, bottom: 5),
                decoration: BoxDecoration(
                    color: LightColors.PRIMARY_COLOR,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40))),
                child: Row(
                  children: [
                    Text(
                      Strings.sort.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      'assets/svg/sort.svg',
                      width: 13,
                      matchTextDirection: true,
                    ),
                  ],
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function onTap;
  const SearchBox(
      {Key? key, required this.textEditingController, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      controller: textEditingController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      style: Theme.of(context)
          .textTheme
          .bodyText1
          ?.copyWith(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 35,
                width: 35,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: LightColors.ACCENT_COLOR,
                    borderRadius: BorderRadius.circular(5)),
                child: SvgPicture.asset(
                  'assets/svg/search_icon.svg',
                ),
              ),
            ],
          ),
          errorStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.redAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: Strings.Search_by_keyword.tr,
          hintStyle:
              TextStyle(color: LightColors.TEXT_HINT_COLOR, fontSize: 14.0),
          filled: true,
          fillColor: LightColors.EDIT_BACKGROUND_COLOR,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: LightColors.EDIT_BORDER_FOCUSED_COLOR),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            //borderSide: BorderSide(color: Colors.white),
            borderSide: BorderSide(color: Colors.grey[300]!),
          )),
    );
  }
}

class ListItem extends StatelessWidget {
  final Company company;
  final String type;
  const ListItem({Key? key, required this.company, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.USER_CATEGORY_DETAILS, arguments: [company.id]),
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 5),
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Booster.textSecondaryTitle(
                      context,
                      company.nameCorporation ?? "-",
                    ),
                    Booster.textBody(context, type, textSize: 11),
                    RatingBar.builder(
                      initialRating: (company.rateTotal ?? 0).toDouble() / 2,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      ignoreGestures: true,
                      itemSize: 15,
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
                    SizedBox(
                      height: 12,
                      child: Booster.textBody(context, company.desceptionAr!,
                          withHeight: true, textSize: 10),
                    ),
                    if (company.distance != null)
                      Booster.textBody(
                          context,
                          Strings.away.tr +
                              company.distance!.toStringAsFixed(2) +
                              Strings.how_much.tr,
                          withHeight: false,
                          textSize: 10),
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
