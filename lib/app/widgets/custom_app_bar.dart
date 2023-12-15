import 'package:asas/app/theme/lightColors.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, String title, {bool hasBack = true, double radius = 20}) {
  return AppBar(
    title: Text(title, style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),),
    iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage("assets/images/zas.png"),
        //   fit: BoxFit.cover,
        // ),
        color: LightColors.PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(15)
      ),
    ),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(radius),
      ),
    ),
    bottom: PreferredSize(
        child: SizedBox(height: 8.0,),
        preferredSize: Size.fromHeight(8.0),
    ),
    automaticallyImplyLeading: hasBack,
  );
}
