import 'package:asas/app/data/model/program.dart';
import 'package:asas/app/data/model/service.dart';
import 'package:asas/app/modules/user/home/controllers/home_controller.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/image_slider.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:asas/app/widgets/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/user_program_details_controller.dart';

class UserProgramDetailsView extends GetView<UserProgramDetailsController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.Reservation.tr),
        centerTitle: true,
      ),
      body: GetBuilder<UserProgramDetailsController>(
          id: 'main',
          builder: (ctrl) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Booster.textTitle(context,
                            Strings.Congratulations_our_dear_customer.tr),
                        Booster.horizontalSpace(10),
                        SvgPicture.asset("assets/svg/party.svg")
                      ],
                    ),
                    Booster.verticalSpace(10),
                    Booster.textBody(context, Strings.away_from_submitting.tr,
                        textAlign: TextAlign.start),
                    Booster.verticalSpace(10),
                    Booster.textBody(context, Strings.Booking_Advantages.tr,
                        textSize: 15,
                        color: LightColors.PRIMARY_COLOR,
                        fontWeight: FontWeight.bold),
                    Booster.verticalSpace(5),
                    Booster.textBody(context, controller.program.descriptionAr!,
                        color: LightColors.TEXT_PRIMARY_COLOR),
                    Booster.verticalSpace(10),
                    Divider(
                      color: LightColors.DIVIDER_COLOR,
                    ),
                    Booster.verticalSpace(10),
                    Booster.textBody(context, Strings.Program_Specifications.tr,
                        textSize: 15,
                        color: LightColors.PRIMARY_COLOR,
                        fontWeight: FontWeight.bold),
                    Booster.verticalSpace(10),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //if(controller.company != null)
                            Booster.textBody(
                                context, Strings.name_corporation2.tr),
                            Booster.textBody(
                                context, Strings.Enterprise_website.tr),
                            Booster.textBody(context, Strings.name_ar.tr),
                          ],
                        ),
                        Booster.horizontalSpace(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //if(controller.company != null)
                            Booster.textBody(context,
                                controller.program.name_corporation ?? '',
                                color: LightColors.TEXT_PRIMARY_COLOR),
                            Booster.textBody(
                                context,
                                (controller.program.country ?? '') +
                                    " - " +
                                    (controller.program.city ?? ''),
                                color: LightColors.TEXT_PRIMARY_COLOR),
                            Booster.textBody(
                                context, controller.program.nameAr ?? '',
                                color: LightColors.TEXT_PRIMARY_COLOR),
                          ],
                        )
                      ],
                    ),
                    Booster.verticalSpace(10),
                    Divider(
                      color: LightColors.DIVIDER_COLOR,
                    ),
                    if (controller.program.urlViedo!.contains("http"))
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.program.urlViedo != null) ...[
                            Booster.verticalSpace(10),
                            Booster.textBody(
                                context, Strings.Program_activities_video.tr,
                                textSize: 15,
                                color: LightColors.PRIMARY_COLOR,
                                fontWeight: FontWeight.bold),
                            Booster.verticalSpace(10),
                            VideoWidget(
                              url: controller.program.urlViedo!,
                              //url: "https://www.youtube.com/watch?v=O--o-O-ABBw",
                            ),
                            Booster.verticalSpace(10),
                          ]
                        ],
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.program.media!.isNotEmpty) ...[
                          Booster.textBody(
                              context, Strings.Pictures_activities.tr,
                              textSize: 15,
                              color: LightColors.PRIMARY_COLOR,
                              fontWeight: FontWeight.bold),
                          Booster.verticalSpace(10),
                          ImageSlider(
                            images: controller.program.media!
                                .map((e) => e.media!)
                                .toList(),
                          ),
                          Booster.verticalSpace(10),
                        ]
                      ],
                    ),
                    if (ctrl.program.service!.isNotEmpty) ...[
                      Divider(
                        color: LightColors.DIVIDER_COLOR,
                      ),
                      Booster.verticalSpace(10),
                      Booster.textBody(context, Strings.additional_services.tr,
                          textSize: 15,
                          color: LightColors.PRIMARY_COLOR,
                          fontWeight: FontWeight.bold),
                      Booster.verticalSpace(10),
                      OtherService(
                        services: ctrl.program.service!,
                        program: ctrl.program,
                        coins: ctrl.program.getCoinsNameAr() ?? '',
                      ),
                    ],
                    // Booster.verticalSpace(10),
                    // Divider(color: LightColors.DIVIDER_COLOR,),
                    // Booster.verticalSpace(10),
                    // Booster.textBody(context, "بيانات الحاجز",
                    //     textSize: 15,
                    //     color: LightColors.PRIMARY_COLOR,
                    //     fontWeight: FontWeight.bold),
                    // Booster.verticalSpace(10),
                    // Row(
                    //   children: [
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Booster.textBody(context, 'اسم ولي الامر'),
                    //         Booster.textBody(context, 'اسم الطالب'),
                    //         Booster.textBody(context, 'تاريخ ميلاد الطالب'),
                    //         Booster.textBody(context, 'رقم الهاتف'),
                    //       ],
                    //     ),
                    //     Booster.horizontalSpace(20),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Booster.textBody(context, "عبدالله السيد عبدالله", color: LightColors.TEXT_PRIMARY_COLOR),
                    //         Booster.textBody(context, "محمد عبدالله السيد", color: LightColors.TEXT_PRIMARY_COLOR),
                    //         Booster.textBody(context, "1/12/2014", color: LightColors.TEXT_PRIMARY_COLOR),
                    //         Booster.textBody(context, "+9665849125", color: LightColors.TEXT_PRIMARY_COLOR),
                    //       ],
                    //     )
                    //   ],
                    // ),
                    Booster.verticalSpace(10),
                    Divider(
                      color: LightColors.DIVIDER_COLOR,
                    ),
                    Booster.verticalSpace(10),
                    Booster.textBody(context, Strings.Price_details.tr,
                        textSize: 15,
                        color: LightColors.PRIMARY_COLOR,
                        fontWeight: FontWeight.bold),
                    Booster.verticalSpace(10),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Booster.textBody(
                                context, Strings.The_original_price_program.tr),
                            if (ctrl.program.discount!.isNotEmpty)
                              Booster.textBody(context,
                                  Strings.The_current_discount_program.tr),
                            if (ctrl.program.discount!.isNotEmpty)
                              Booster.textBody(
                                  context, Strings.The_price_after_discount.tr),
                          ],
                        ),
                        Booster.horizontalSpace(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Booster.textBody(
                                context,
                                ctrl.program.getPrice().toStringAsFixed(2) +
                                    " " +
                                    (ctrl.program.getCoinsNameAr() ?? ''),
                                color: LightColors.TEXT_PRIMARY_COLOR),
                            if (ctrl.program.discount!.isNotEmpty)
                              Booster.textBody(context,
                                  "${ctrl.program.discount!.last.priceRateDiscount}% ${Strings.from_price.tr}",
                                  color: LightColors.TEXT_PRIMARY_COLOR),
                            if (ctrl.program.discount!.isNotEmpty)
                              Booster.textBody(
                                  context,
                                  ctrl.priceAfterDiscount().toStringAsFixed(2) +
                                      " " +
                                      (ctrl.program.getCoinsNameAr() ?? ''),
                                  color: LightColors.TEXT_PRIMARY_COLOR),
                          ],
                        )
                      ],
                    ),
                    Booster.verticalSpace(10),
                    Divider(
                      color: LightColors.DIVIDER_COLOR,
                    ),
                    Booster.verticalSpace(10),
                    Booster.textBody(
                        context, Strings.Notes_basic_program_price.tr,
                        textSize: 15,
                        color: LightColors.PRIMARY_COLOR,
                        fontWeight: FontWeight.bold),
                    Booster.textBody(
                        context, "(${Strings.Without_additional_services.tr})",
                        textSize: 13,
                        color: LightColors.ACCENT_COLOR,
                        fontWeight: FontWeight.bold),
                    Booster.verticalSpace(10),
                    Booster.textBody(
                        context, ctrl.program.priceNoteAr.toString(),
                        color: LightColors.TEXT_PRIMARY_COLOR,
                        textAlign: TextAlign.start),
                    Booster.verticalSpace(10),
                    Divider(
                      color: LightColors.DIVIDER_COLOR,
                    ),
                    Booster.verticalSpace(10),
                    GetBuilder<UserProgramDetailsController>(
                        id: 'priceAfter',
                        builder: (ctrl) {
                          return Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Booster.textBody(context,
                                      Strings.Price_after_adding_services.tr,
                                      color: LightColors.TEXT_PRIMARY_COLOR),
                                ],
                              ),
                              Booster.horizontalSpace(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Booster.textTitle(
                                      context,
                                      ctrl.program.priceAfterAddingService
                                              .toString() +
                                          " " +
                                          (ctrl.program.getCoinsNameAr() ?? ''),
                                      color: LightColors.TEXT_ACCENT_COLOR),
                                ],
                              )
                            ],
                          );
                        }),
                    Booster.verticalSpace(40),
                    MyButton(
                        title: Strings.Submit_reservation_request.tr,
                        onTap: controller.selectStudent),
                    Booster.verticalSpace(30),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class OtherService extends StatelessWidget {
  final List<Service> services;
  final String coins;
  final Program program;
  const OtherService(
      {Key? key,
      required this.services,
      required this.coins,
      required this.program})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: services.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => OtherServiceItem(
          service: services[index], coins: coins, program: program),
    );
  }
}

class OtherServiceItem extends StatefulWidget {
  final Service service;
  final String coins;
  final Program program;
  const OtherServiceItem(
      {Key? key,
      required this.service,
      required this.coins,
      required this.program})
      : super(key: key);

  @override
  State<OtherServiceItem> createState() => _OtherServiceItemState();
}

class _OtherServiceItemState extends State<OtherServiceItem> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      return LightColors.ACCENT_COLOR;
    }

    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: widget.service.selected,
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          fillColor: MaterialStateProperty.resolveWith(getColor),
          onChanged: (bool? value) {
            setState(() {
              widget.service.selected = value!;
              Get.find<UserProgramDetailsController>().updateTotalPrice();
            });
          },
        ),
        Booster.horizontalSpace(10),
        Booster.textBody(context, widget.service.serviceAr!),
        Booster.horizontalSpace(10),
        Booster.textBody(context,
            "${widget.service.getPrice(widget.program.coins, widget.program.coins_name_ar, widget.program.coins_name_en).toStringAsFixed(2)} ${widget.coins}",
            color: LightColors.ACCENT_COLOR2)
      ],
    );
  }
}
