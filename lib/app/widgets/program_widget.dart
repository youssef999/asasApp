import 'dart:io';

import 'package:asas/app/data/model/discount.dart';
import 'package:asas/app/data/model/service.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../translations/strings_enum.dart';

class OtherServices extends StatelessWidget {
  final Function onAddClick ;
  final Function onDeleteClicked ;
  final List<Service> serviceList;
  const OtherServices({Key? key, required this.onAddClick, required this.serviceList, required this.onDeleteClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Booster.textBody(context, Strings.additional_services.tr, color: LightColors.TEXT_PRIMARY_COLOR),
              ElevatedButton(
                onPressed: () => onAddClick(),
                child: Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, shape: CircleBorder(), backgroundColor: LightColors.PRIMARY_COLOR,
                  minimumSize: Size.zero,
                  padding: EdgeInsets.all(5),
                ),
              ),
            ],
          ),
          Booster.verticalSpace(5),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: serviceList.length,
            itemBuilder: (_, index) => OtherServiceListItem(
              service: serviceList[index],
              onDeleteClicked: ()=> onDeleteClicked(index, serviceList[index].id),
            ),
          ),
        ],
      ),
    );
  }
}

class OtherServiceListItem extends StatelessWidget {
  final Service service;
  final Function onDeleteClicked;
  const OtherServiceListItem({Key? key, required this.service, required this.onDeleteClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
          borderRadius: BorderRadius.circular(6),
          color: LightColors.EDIT_BACKGROUND_COLOR
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Booster.textBody(context, Strings.service.tr , color: LightColors.TEXT_PRIMARY_COLOR),
                  Booster.horizontalSpace(5),
                  Booster.textBody(context, service.serviceAr!, color: LightColors.PRIMARY_COLOR, fontWeight: FontWeight.bold),
                ],
              ),
              GestureDetector(
                onTap: ()=> onDeleteClicked(),
                child: Container(
                  height: 27,
                  width: 27,
                  decoration: BoxDecoration(
                      color:
                      LightColors.ICON_COLOR_DELETE,
                      borderRadius:
                      BorderRadius.circular(5)),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          Booster.verticalSpace(5),
          Row(
            children: [
              Booster.textBody(context, 'السعر : ', color: LightColors.TEXT_PRIMARY_COLOR),
              Booster.horizontalSpace(5),
              Booster.textBody(context, service.price!, color: LightColors.PRIMARY_COLOR, fontWeight: FontWeight.bold),
            ],
          ),
        ],
      ),
    );
  }
}


class MediaSection extends StatelessWidget {
  final List<dynamic> imageModelList ;
  final Function onAddClick;
  final Function onDeleteClicked;
  final String title;
  final String imageBaseUrl; // programs , company
  const MediaSection({Key? key, required this.imageModelList, required this.onAddClick, required this.onDeleteClicked, required this.title, required this.imageBaseUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Booster.textBody(context, title, color: LightColors.TEXT_PRIMARY_COLOR),
              ElevatedButton(
                onPressed: ()=> onAddClick(),
                child: Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, shape: CircleBorder(), backgroundColor: LightColors.PRIMARY_COLOR,
                  minimumSize: Size.zero,
                  padding: EdgeInsets.all(5),
                ),
              ),
            ],
          ),
          Booster.verticalSpace(5),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: imageModelList.length,
            itemBuilder: (_, index) => MediaListItem(
              imageModel: imageModelList[index],
              imageBaseUrl: imageBaseUrl,
              onDeleteClicked: ()=> onDeleteClicked(index, imageModelList[index].id),
            ),
          )

        ],
      ),
    );
  }
}

class MediaListItem extends StatelessWidget {
  final dynamic imageModel;
  final Function onDeleteClicked;
  final String imageBaseUrl;
  const MediaListItem({Key? key, required this.imageModel, required this.onDeleteClicked, required this.imageBaseUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: imageModel.path == null ? Image.network(imageBaseUrl + imageModel.media, width: 50, height: 50) :Image.file(File(imageModel.path!), width: 50, height: 50),
                  ),
                  Booster.horizontalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Booster.textBody(context,  "..."+ (imageModel.name != null ? imageModel.name!.substring(imageModel.name!.length - 10, imageModel.name!.length) : imageModel.media.substring(imageModel.media!.length - 10, imageModel.media!.length)),),
                    ],
                  )
                ],
              ),
              GestureDetector(
                onTap: ()=> onDeleteClicked(),
                child: Container(
                  height: 27,
                  width: 27,
                  decoration: BoxDecoration(
                      color:
                      LightColors.ICON_COLOR_DELETE,
                      borderRadius:
                      BorderRadius.circular(5)),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey.withOpacity(0.5),)
        ],
      ),
    );
  }
}



class DiscountSection extends StatelessWidget {
  final Function onAddClick;
  final Function onDeleteClicked;
  final List<Discount> discountList;
  const DiscountSection({Key? key, required this.onAddClick, required this.discountList, required this.onDeleteClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Booster.textBody(context, Strings.Price_reduction_percentage.tr, color: LightColors.TEXT_PRIMARY_COLOR),
              ElevatedButton(
                onPressed: ()=> onAddClick(),
                child: Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, shape: CircleBorder(), backgroundColor: LightColors.PRIMARY_COLOR,
                  minimumSize: Size.zero,
                  padding: EdgeInsets.all(5),
                ),
              ),
            ],
          ),
          Booster.verticalSpace(5),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: discountList.length,
            shrinkWrap: true,
            itemBuilder: (_, index)=> DiscountListItem(
              discount: discountList[index],
              onDeleteClicked: ()=> onDeleteClicked(index, discountList[index].id),
            ),
          ),
        ],
      ),
    );
  }
}

class DiscountListItem extends StatelessWidget {
  final Discount discount;
  final Function onDeleteClicked;
  const DiscountListItem({Key? key, required this.discount, required this.onDeleteClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
          borderRadius: BorderRadius.circular(6),
          color: LightColors.EDIT_BACKGROUND_COLOR
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Booster.textBody(context, Strings.discount_percentage.tr, color: LightColors.TEXT_PRIMARY_COLOR),
                  Booster.horizontalSpace(5),
                  Booster.textBody(context, '${discount.priceRateDiscount}%', color: LightColors.PRIMARY_COLOR, fontWeight: FontWeight.bold),
                ],
              ),
              GestureDetector(
                onTap: () => onDeleteClicked(),
                child: Container(
                  height: 27,
                  width: 27,
                  decoration: BoxDecoration(
                      color:
                      LightColors.ICON_COLOR_DELETE,
                      borderRadius:
                      BorderRadius.circular(5)),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          Booster.verticalSpace(5),
          Row(
            children: [
              Booster.textBody(context, '${Strings.From.tr} : ',),
              Booster.textBody(context, discount.startDiscount!, color: LightColors.TEXT_PRIMARY_COLOR),
              Booster.horizontalSpace(10),
              Booster.textBody(context, '${Strings.to_me.tr} : ',),
              Booster.textBody(context, discount.endDiscount!, color: LightColors.TEXT_PRIMARY_COLOR),
            ],
          ),
          // Booster.verticalSpace(5),
          // Row(
          //   children: [
          //     Booster.textBody(context, 'السعر بعد التخفيض : ',),
          //     Booster.textBody(context, '${discount.endDiscount}\$', color: LightColors.TEXT_PRIMARY_COLOR),
          //   ],
          // ),
        ],
      ),
    );
  }
}

