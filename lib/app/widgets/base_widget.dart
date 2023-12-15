import 'package:asas/app/modules/user/home/controllers/home_controller.dart';
import 'package:asas/app/modules/user/home/views/home_view.dart';
import 'package:asas/app/modules/user/my_drawer/controllers/my_drawer_controller.dart';
import 'package:asas/app/modules/user/my_drawer/views/my_drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(MyDrawerController());
    return Scaffold(
      body: Stack(
        children: [
          MyDrawerView(),
          HomeView(),
        ],
      ),
    );
  }
}


