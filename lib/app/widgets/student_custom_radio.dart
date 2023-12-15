import 'package:asas/app/data/model/student.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef Callback = void Function(List<int> studentsId);

class StudentCustomRadio extends StatefulWidget {
  final Callback onSelect;
  final List<Student> studentList;

  StudentCustomRadio({Key? key, required this.onSelect, required this.studentList}) : super(key: key);

  @override
  _StudentCustomRadioState createState() => _StudentCustomRadioState();
}

class _StudentCustomRadioState extends State<StudentCustomRadio> {
  List<RadioModel> sampleData = <RadioModel>[];

  @override
  void initState() {
    widget.studentList.map((e) => sampleData.add(RadioModel(false, e.name!, e.id!))).toList();
    super.initState();
  }

  getIds(){
    final List<int> list = [];
    for(var item in sampleData){
      if(item.isSelected){
        list.add(item.id);
      }
    }
    widget.onSelect(list);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        physics: const BouncingScrollPhysics(),
        itemCount: sampleData.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                sampleData[index].isSelected = !sampleData[index].isSelected;
                getIds();
              });
            },
            child: RadioItem(sampleData[index]),
          );
        },
      ),
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
