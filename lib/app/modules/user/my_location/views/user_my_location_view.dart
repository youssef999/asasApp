import 'package:asas/app/data/model/my_location.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/user_my_location_controller.dart';

class UserMyLocationView extends GetView<UserMyLocationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.detect_location.tr),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          controller.addLocation();
        },
        backgroundColor: LightColors.PRIMARY_COLOR,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Booster.textBody(context, Strings.Please_select_location.tr, color: LightColors.PRIMARY_COLOR),
            GetBuilder<UserMyLocationController>(
              builder: (ctrl) {
                return Expanded(
                  child: ctrl.locations.isNotEmpty ? ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: ctrl.locations.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => ctrl.onSelect(index),
                        child: RadioItem(ctrl.locations[index], (id)=> controller.deleteLocation(id)),
                      );
                    },
                  ) : Container(
                    child: Center(
                      child: Booster.textTitle(context,  Strings.There_are_no_sites.tr ),
                    ),
                  )
                );
              }
            )
          ],
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final MyLocation _item;
  final Function delete;
  RadioItem(this._item, this.delete);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: _item.isSelected!
                  ? LightColors.PRIMARY_COLOR
                  : LightColors.EDIT_BORDER_COLOR)),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset('assets/svg/owner/card_zaz_right.svg',
                height: 60),
          ),
          if (_item.isSelected!)
            Positioned(
              top: -8,
              left: -8,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: LightColors.PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(Icons.check, color: Colors.white, size: 15),
              ),
            ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 15,
            left: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Booster.textBody(context, _item.name!,
                    fontWeight: FontWeight.bold,
                    color: LightColors.TEXT_PRIMARY_COLOR),
                IconButton(
                    onPressed: ()=> delete(_item.id),
                    icon: Icon(Icons.delete, color: Colors.redAccent,))
              ],
            ),
          )
        ],
      ),
    );
  }
}

