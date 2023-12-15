
import 'package:flutter/material.dart';


  PreferredSizeWidget? myAppBar({required String title, Color color = Colors.white, Color textColor = Colors.black, Color iconColor = Colors.black}){
    return AppBar(
      backgroundColor: color,
      iconTheme: IconThemeData(color: iconColor),
      title: Text(title, style: TextStyle(color: textColor),),
      centerTitle: true,
    );
  }