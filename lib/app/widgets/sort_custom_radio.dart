import 'package:asas/app/data/model/my_location.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../translations/strings_enum.dart';

typedef Callback = void Function(int index);

class SortCustomRadio extends StatefulWidget {
  final Callback onSelect;
  final int selectedIndex;

  SortCustomRadio(
      {Key? key, required this.onSelect, required this.selectedIndex})
      : super(key: key);

  @override
  SortCustomRadioState createState() => SortCustomRadioState();
}

class SortCustomRadioState extends State<SortCustomRadio> {
  List<RadioModel> sampleData = <RadioModel>[];

  @override
  void initState() {
    super.initState();
    // sampleData.add(RadioModel(true, 'السعر من الأعلى الى الاقل', 0));
    // sampleData.add(RadioModel(false, 'السعر من الأقل الى الأعلى', 1));

    sampleData.add(RadioModel(widget.selectedIndex == 1, Strings.city.tr, 1));
    sampleData
        .add(RadioModel(widget.selectedIndex == 2, Strings.District.tr, 2));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10),
      physics: const BouncingScrollPhysics(),
      itemCount: sampleData.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            widget.onSelect(index + 1);
            setState(() {
              for (var element in sampleData) {
                element.isSelected = false;
              }
              sampleData[index].isSelected = true;
            });
          },
          child: RadioItem(sampleData[index]),
        );
      },
    );
  }
}

class SortCustomRadioV extends StatefulWidget {
  final Callback onSelect;
  final int selectedIndex;

  SortCustomRadioV(
      {Key? key, required this.onSelect, required this.selectedIndex})
      : super(key: key);

  @override
  SortCustomRadioVState createState() => SortCustomRadioVState();
}

class SortCustomRadioVState extends State<SortCustomRadioV> {
  List<RadioModel> sampleData = <RadioModel>[];

  @override
  void initState() {
    super.initState();
    // sampleData.add(RadioModel(true, 'السعر من الأعلى الى الاقل', 0));
    // sampleData.add(RadioModel(false, 'السعر من الأقل الى الأعلى', 1));

    sampleData.add(RadioModel(widget.selectedIndex == 3, Strings.recent.tr, 3));

    sampleData
        .add(RadioModel(widget.selectedIndex == 4, Strings.Top_Rated.tr, 4));

    final List<MyLocation>? list = PreferenceUtils.getMyLocations();
    if (list != null) {
      for (var item in list) {
        print("thossc ${item.toJson()}");
        if (item.isSelected!) {
          sampleData.add(RadioModel(widget.selectedIndex == 5,
              '${Strings.closest_to.tr} ${item.name}', 5));
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10),
      physics: const BouncingScrollPhysics(),
      itemCount: sampleData.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            widget.onSelect(index + 3);
            setState(() {
              for (var element in sampleData) {
                element.isSelected = false;
              }
              sampleData[index].isSelected = true;
            });
          },
          child: RadioItem(sampleData[index]),
        );
      },
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: _item.isSelected
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
          if (_item.isSelected)
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
              children: [
                Booster.textBody(context, _item.buttonText,
                    fontWeight: FontWeight.bold,
                    color: LightColors.TEXT_PRIMARY_COLOR),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final int id;

  RadioModel(this.isSelected, this.buttonText, this.id);
}
