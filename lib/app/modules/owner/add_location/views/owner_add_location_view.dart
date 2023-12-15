import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../translations/strings_enum.dart';
import '../controllers/owner_add_location_controller.dart';

class OwnerAddLocationView extends GetView<OwnerAddLocationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: Strings.detect_location.tr, color: LightColors.PRIMARY_COLOR, iconColor: Colors.white, textColor: Colors.white),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GetBuilder<OwnerAddLocationController>(
              id: "map",
              builder: (context) {
                return GoogleMap(
                  mapType: MapType.normal,
                 // markers: controller.markers,
                  onTap: controller.onMapTap,
                  myLocationButtonEnabled: true,
                  compassEnabled: false,
                  initialCameraPosition: controller.cameraPosition,
                  onMapCreated: (GoogleMapController ctrl) async {
                    try{
                      controller.mapCompleter.complete(ctrl);
                      controller.googleMapController =
                      await controller.mapCompleter.future;
                      controller.googleMapController!.animateCamera(
                          CameraUpdate.newCameraPosition(controller.cameraPosition));
                    }catch(_){}

                  },
                  myLocationEnabled: true,
                );
              }
          ),

          Positioned(
            bottom: 45,
            left: 25,
            right: 25,
            child: Material(
              child: InkWell(
                onTap: ()=> controller.save(),
                borderRadius:
                BorderRadius.circular(7),
                child: Ink(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0),
                  decoration: BoxDecoration(
                    color: LightColors.ACCENT_COLOR,
                    borderRadius:
                    BorderRadius.circular(7),
                  ),
                  child: Text(
                    Strings.detect.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
