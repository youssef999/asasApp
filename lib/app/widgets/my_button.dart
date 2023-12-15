import 'package:asas/app/theme/lightColors.dart';
import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  final String title;
  final bool secondary;
  final Function? onTap;
  final double padding;

  const MyButton(
      {Key? key,
      required this.title,
      this.secondary = false,
      this.onTap,
      this.padding = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
              onTap!();
          },
          borderRadius: BorderRadius.circular(7),
          child: Ink(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            height: 46,
            decoration: BoxDecoration(
              color: secondary
                  ? LightColors.BUTTON_ACCENT_COLOR
                  : LightColors.PRIMARY_COLOR,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secondary ? LightColors.TEXT_PRIMARY_COLOR :Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
