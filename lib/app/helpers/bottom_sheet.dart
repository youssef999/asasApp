import 'package:asas/app/data/model/reservation_status.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/filter_custom_radio.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../translations/strings_enum.dart';
import '../widgets/sort_custom_radio.dart';

typedef Callback = void Function(int? actionId);

typedef DiscountCallback = void Function(
    String discount, String dataFrom, String dataTo);
typedef ServiceCallback = void Function(
    String price, String serviceAr, String serviceEn);
typedef CommentCallback = void Function(String comment);
typedef RatingCallback = void Function(
    double? r_1, double? r_2, double? r_3, double? r_4, double? r_5);

class BottomSheetUtils {
  static showAgreementBottomSheet(context, String data) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        // enableDrag: true,
        // isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Container(
            // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height: 8,
                    decoration: BoxDecoration(
                        color: LightColors.ACCENT_COLOR,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: Html(
                  data: data,
                ))
              ],
            ),
          );
        });
  }

  static showAddCommentBottomSheet(context,
      {required CommentCallback onSubmit}) {
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        // enableDrag: true,
        // isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Container(
            margin: MediaQuery.of(context).viewInsets,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height: 8,
                    decoration: BoxDecoration(
                        color: LightColors.ACCENT_COLOR,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Booster.textSecondaryTitle(
                            context, Strings.ADD_OPINION.tr),
                        Booster.verticalSpace(15),
                        TextBox(
                          controller: commentController,
                          hint: Strings.Write_review.tr,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          lines: 5,
                        ),
                        Booster.verticalSpace(25),
                        MyButton(
                          title: Strings.ADD.tr,
                          onTap: () {
                            if (commentController.text.isNotEmpty) {
                              onSubmit(
                                commentController.text,
                              );
                            } else {
                              CustomLoading.showWrongToast(
                                  msg: Strings.Fill_all_fields.tr);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  static showAddServiceBottomSheet(context,
      {required DiscountCallback onSubmit}) {
    final TextEditingController priceController = TextEditingController();
    final TextEditingController serviceArController = TextEditingController();
    final TextEditingController serviceEnController = TextEditingController();

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return Container(
            margin: MediaQuery.of(context).viewInsets,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height: 8,
                    decoration: BoxDecoration(
                        color: LightColors.ACCENT_COLOR,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Booster.textSecondaryTitle(
                            context, Strings.Add_service.tr),
                        Booster.verticalSpace(15),
                        TextBox(
                          controller: priceController,
                          hint: Strings.Service_price.tr,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                        Booster.verticalSpace(10),
                        TextBox(
                          controller: serviceArController,
                          hint: Strings.Service_name_ar.tr,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                        Booster.verticalSpace(10),
                        TextBox(
                          controller: serviceEnController,
                          hint: Strings.Service_name_en.tr,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        ),
                        Booster.verticalSpace(25),
                        MyButton(
                          title: Strings.ADD.tr,
                          onTap: () {
                            if (priceController.text.isNotEmpty &&
                                serviceArController.text.isNotEmpty &&
                                serviceEnController.text.isNotEmpty) {
                              onSubmit(
                                  priceController.text,
                                  serviceArController.text,
                                  serviceEnController.text);
                            } else {
                              CustomLoading.showWrongToast(
                                  msg: Strings.Fill_all_fields.tr);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  static showAddDiscountBottomSheet(context,
      {required DiscountCallback onSubmit}) {
    final TextEditingController discountController = TextEditingController();
    String? dataFrom;
    DateTime? dataTimeFrom;
    String? dataTo;

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        // enableDrag: true,
        // isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Container(
            margin: MediaQuery.of(context).viewInsets,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height: 8,
                    decoration: BoxDecoration(
                        color: LightColors.ACCENT_COLOR,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Booster.textSecondaryTitle(
                            context, Strings.Add_discount.tr),
                        Booster.verticalSpace(15),
                        TextBox(
                          controller: discountController,
                          hint: Strings.Percent_reduction.tr,
                          keyboardType: TextInputType.number,
                        ),
                        Booster.verticalSpace(10),
                        StatefulBuilder(builder: (context, setState) {
                          return Column(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  picker.DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2021, 1, 1),
                                      onConfirm: (date) {
                                    setState(() {
                                      //2022/04/01
                                      dataTimeFrom = date;
                                      String from =
                                          DateFormat('yyyy/MM/dd').format(date);
                                      dataFrom = from;
                                    });
                                  },
                                      currentTime: DateTime.now(),
                                      locale: picker.LocaleType.ar);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: LightColors.EDIT_BACKGROUND_COLOR,
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Colors.grey[300]!)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: (dataFrom == null)
                                            ? Text(
                                                Strings.From_the_date_of.tr,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: LightColors
                                                        .TEXT_HINT_COLOR),
                                              )
                                            : Text(
                                                dataFrom!,
                                                style:
                                                    TextStyle(fontSize: 12.0),
                                              ),
                                      ),
                                      Icon(
                                        Icons.date_range,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (dataFrom != null) ...[
                                Booster.verticalSpace(10),
                                InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    picker.DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: dataTimeFrom ??
                                            DateTime(2021, 1, 1),
                                        onConfirm: (date) {
                                      setState(() {
                                        //2022/04/01
                                        String to = DateFormat('yyyy/MM/dd')
                                            .format(date);
                                        dataTo = to;
                                      });
                                    },
                                        currentTime: DateTime.now(),
                                        locale: picker.LocaleType.ar);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        color:
                                            LightColors.EDIT_BACKGROUND_COLOR,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey[300]!)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: (dataTo == null)
                                              ? Text(
                                                  Strings.To_date.tr,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: LightColors
                                                          .TEXT_HINT_COLOR),
                                                )
                                              : Text(
                                                  dataTo!,
                                                  style:
                                                      TextStyle(fontSize: 12.0),
                                                ),
                                        ),
                                        Icon(
                                          Icons.date_range,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              Booster.verticalSpace(25),
                              MyButton(
                                title: Strings.ADD.tr,
                                onTap: () {
                                  if (discountController.text.isNotEmpty &&
                                      dataFrom != null &&
                                      dataTo != null) {
                                    onSubmit(discountController.text, dataFrom!,
                                        dataTo!);
                                  } else {
                                    CustomLoading.showWrongToast(
                                        msg: Strings.Fill_all_fields.tr);
                                  }
                                },
                              )
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  static showRattingBottomSheet(context, RatingCallback onSubmit) {
    double? r_1 = 1;
    double? r_2 = 1;
    double? r_3 = 1;
    double? r_4 = 1;
    double? r_5 = 1;

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        // enableDrag: true,
        // isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Container(
            // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height: 8,
                    decoration: BoxDecoration(
                        color: LightColors.ACCENT_COLOR,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Booster.textTitle(context, Strings.Add_review.tr,
                          color: LightColors.PRIMARY_COLOR),
                      SizedBox(
                        height: 25,
                      ),
                      RattingItem(
                          title: Strings.Scientific_level.tr,
                          id: 1,
                          onRatingUpdate: (rating) => r_1 = rating),
                      RattingItem(
                          title: Strings.activity_level.tr,
                          id: 2,
                          onRatingUpdate: (rating) => r_2 = rating),
                      RattingItem(
                          title: Strings.Buildings_and_stadiums.tr,
                          id: 3,
                          onRatingUpdate: (rating) => r_3 = rating),
                      RattingItem(
                          title: Strings.Attention_and_communication.tr,
                          id: 4,
                          onRatingUpdate: (rating) => r_4 = rating),
                      RattingItem(
                          title: Strings.Discipline_and_hygiene.tr,
                          id: 5,
                          onRatingUpdate: (rating) => r_5 = rating),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                )),
                MyButton(
                    title: Strings.Evaluation.tr,
                    onTap: () => onSubmit(r_1, r_2, r_3, r_4, r_5),
                    padding: 10)
              ],
            ),
          );
        });
  }

  static showFilterBottomSheet(context, Callback onSubmit) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        // enableDrag: true,
        // isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Container(
            // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height: 8,
                    decoration: BoxDecoration(
                        color: LightColors.ACCENT_COLOR,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: FilterCustomRadio(
                  onSelect: (index) {},
                ))
              ],
            ),
          );
        });
  }

  static showSortBottomSheet(context, int selectedIndex, Callback onSubmit) {
    print("thoss $selectedIndex");
    print("thoss ${onSubmit.toString()}");
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        // enableDrag: true,
        // isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Container(
            // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height: 8,
                    decoration: BoxDecoration(
                        color: LightColors.ACCENT_COLOR,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: SortCustomRadio(
                  selectedIndex: selectedIndex,
                  onSelect: (index) {
                    onSubmit(index);
                  },
                ))
              ],
            ),
          );
        });
  }
static showSortBottomSheetV(context, int selectedIndex, Callback onSubmit) {
    print("thoss $selectedIndex");
    print("thoss ${onSubmit.toString()}");
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        // enableDrag: true,
        // isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Container(
            // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height: 8,
                    decoration: BoxDecoration(
                        color: LightColors.ACCENT_COLOR,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: SortCustomRadioV(
                  selectedIndex: selectedIndex,
                  onSelect: (index) {
                    onSubmit(index);
                  },
                ))
              ],
            ),
          );
        });
  }
  static showAddActionBottomSheet(
      context, List<ReservationStatus> statusList, Callback onSubmit) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        // enableDrag: true,
        // isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Container(
            // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height: 8,
                    decoration: BoxDecoration(
                        color: LightColors.ACCENT_COLOR,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Booster.textSecondaryTitle(
                            context, Strings.Take_appropriate_action.tr),
                        Booster.verticalSpace(15),
                        ...statusList
                            .map(
                              (e) => MyButton(
                                  title: e.statusAr!,
                                  onTap: () => onSubmit(e.id),
                                  padding: 10),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class RattingItem extends StatelessWidget {
  final String title;
  final int id;
  final Function onRatingUpdate;

  const RattingItem(
      {Key? key,
      required this.onRatingUpdate,
      required this.title,
      required this.id})
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
            RatingBar.builder(
                initialRating: 1,
                minRating: 1,
                maxRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemSize: 20,
                itemCount: 10,
                itemPadding: EdgeInsets.symmetric(horizontal: 0),
                itemBuilder: (context, _) => Icon(
                      Icons.star_rounded,
                      color: LightColors.ACCENT_COLOR,
                    ),
                onRatingUpdate: (rating) => onRatingUpdate(rating)),
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

class TextBox extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? lines;
  const TextBox({
    Key? key,
    required this.controller,
    required this.hint,
    this.lines = 1,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: lines,
      textInputAction: textInputAction,
      style: Theme.of(context)
          .textTheme
          .bodyText1
          ?.copyWith(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
          errorStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.redAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hint,
          hintStyle:
              TextStyle(color: LightColors.TEXT_HINT_COLOR, fontSize: 12.0),
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
