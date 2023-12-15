import 'package:asas/app/theme/lightColors.dart';
import 'package:flutter/material.dart';

class Booster {
  static textTitle(BuildContext context, String text,
      {Color color = LightColors.ACCENT_COLOR, bool withHeight = true}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
          height: withHeight ? 1.4 : null,
          color: color,
          fontWeight: FontWeight.bold),
    );
  }

  static textSecondaryTitle(BuildContext context, String text,
      {bool withHeight = true}) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.headline6?.copyWith(
          height: withHeight ? 1.4 : null,
          color: LightColors.TEXT_PRIMARY_COLOR,
          fontWeight: FontWeight.bold),
    );
  }

  static textBody(BuildContext context, String text,
      {TextAlign textAlign = TextAlign.justify,
      double textSize = 14.0,
      Color color = LightColors.TEXT_SECONDARY_COLOR,
      FontWeight fontWeight = FontWeight.normal,
      bool showMore = false,
      bool withHeight = true,
      bool lineThrough = false}) {
    return
        //   showMore ? ReadMoreText(
        //   text,
        //   trimLines: 3,
        //   colorClickableText: LightColors.ACCENT_COLOR,
        //   trimMode: TrimMode.Line,
        //   style: Theme.of(context).textTheme.headline6?.copyWith(
        //     height: withHeight ? 1.4 : null,
        //     color: color, fontSize: textSize, fontWeight: fontWeight,),
        //   trimCollapsedText: 'عرض المزيد',
        //   trimExpandedText: 'عرض أقل',
        //   textAlign: textAlign,
        // ) :
        Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.headline6?.copyWith(
            height: withHeight ? 1.4 : null,
            decoration: lineThrough ? TextDecoration.lineThrough : null,
            color: color,
            fontSize: textSize,
            fontWeight: fontWeight,
          ),
    );
  }

  static textDetail(
    BuildContext context,
    String text, {
    TextAlign textAlign = TextAlign.justify,
    double textSize = 13.0,
    Color? color,
    FontWeight fontWeight = FontWeight.bold,
    bool withHeight = true,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            height: withHeight ? 1.2 : null,
            color: color,
            fontSize: textSize,
            fontWeight: fontWeight,
          ),
    );
  }

  static textWithIcon(BuildContext context, String text,
      {bool withHeight = true}) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.headline6?.copyWith(
          height: withHeight ? 1.4 : null,
          color: LightColors.TEXT_PRIMARY_COLOR,
          fontWeight: FontWeight.bold,
          fontSize: 13),
    );
  }

  static horizontalSpace(double width) {
    return SizedBox(
      width: width,
    );
  }

  static verticalSpace(double height) {
    return SizedBox(
      height: height,
    );
  }
}
