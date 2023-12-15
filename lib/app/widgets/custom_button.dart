import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  final Color borderColor;
  final String title;
  const CustomButton({
    Key? key,
    required this.color,
    required this.onTap,
    required this.title,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 100,
      child: InkWell(
        onTap: ()=>onTap(),
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Ink(
                // padding: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 15.sp),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: borderColor)
                ),
                child: Center(
                  child: Text(
                    title.tr,
                    style: TextStyle(
                        color: borderColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,

                    ),),
                )
            ),
          ),
        ),
      ),
    );
  }
}
