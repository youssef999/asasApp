import 'package:asas/app/modules/owner/drawer/controllers/owner_drawer_controller.dart';
import 'package:asas/app/modules/owner/drawer/views/owner_drawer_view.dart';
import 'package:asas/app/modules/owner/home/controllers/owner_home_controller.dart';
import 'package:asas/app/modules/owner/home/views/owner_home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OwnerBaseWidget extends StatelessWidget {
  const OwnerBaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OwnerDrawerController());
    Get.put(OwnerHomeController());
    return Scaffold(
      body: Stack(
        children: [
          OwnerDrawerView(),
          OwnerHomeView(),
        ],
      ),
    );
  }
}


