import 'package:asas/app/theme/lightColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/shared_map_controller.dart';

class SharedMapView extends GetView<SharedMapController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 85,
            bottom: 0,
            right: 0,
            left: 0,
            child: GoogleMap(
              onTap: ((argument) {}),
              mapType: MapType.normal,
              markers: controller.createMarkers(),
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              //onTap: controller.onMapTap,
              myLocationButtonEnabled: true,
              compassEnabled: false,
              // gestureRecognizers: {
              //   Factory<OneSequenceGestureRecognizer>(() => ScaleGestureRecognizer()),
              // },
              initialCameraPosition: controller.cameraPosition,
              onMapCreated: (GoogleMapController ctrl) async {
                controller.mapCompleter.complete(ctrl);
                controller.googleMapController =
                    await controller.mapCompleter.future;
                controller.googleMapController!.animateCamera(
                    CameraUpdate.newCameraPosition(controller.cameraPosition));
              },
              myLocationEnabled: true,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: 100.0,
              padding: EdgeInsets.only(top: 20.0),
              decoration: const BoxDecoration(
                color: LightColors.PRIMARY_COLOR,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Expanded(
                      child: Text(
                    Strings.Enterprise_website.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.transparent,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: Container(
          //     height: 120.0,
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          //         boxShadow: [
          //           BoxShadow(
          //               color: Colors.black.withOpacity(0.1),
          //               offset: Offset(0, 0),
          //               blurRadius: 5,
          //               spreadRadius: 5
          //           )
          //         ]
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Center(
          //             child: Container(
          //               height: 8,
          //               width: 50,
          //               decoration: BoxDecoration(
          //                 color: LightColors.PRIMARY_COLOR,
          //                 borderRadius: BorderRadius.circular(5),
          //               ),
          //             ),
          //           ),
          //           // Booster.verticalSpace(10),
          //           // Row(
          //           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           //   children: [
          //           //     Booster.textTitle(context, controller.company.nameCorporation ?? controller.company.owner!.nameCorporation!, color: ),
          //           //   ],
          //           // ),
          //           // Booster.verticalSpace(10),
          //           // RatingBar.builder(
          //           //   initialRating: controller.company.rateTotal!.toDouble() / 2,
          //           //   minRating: 1,
          //           //   maxRating: 5,
          //           //   direction: Axis.horizontal,
          //           //   allowHalfRating: false,
          //           //   ignoreGestures: true,
          //           //   itemSize: 20,
          //           //   itemCount: 5,
          //           //   itemPadding: EdgeInsets.symmetric(horizontal: 0),
          //           //   itemBuilder: (context, _) => Icon(
          //           //     Icons.star_rounded,
          //           //     color: LightColors.TEXT_ACCENT_COLOR,
          //           //   ),
          //           //   onRatingUpdate: (rating) {
          //           //     print(rating);
          //           //   },
          //           // ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
