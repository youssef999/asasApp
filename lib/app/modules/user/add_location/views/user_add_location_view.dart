import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/user_add_location_controller.dart';

class UserAddLocationView extends GetView<UserAddLocationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.Edit_student_formation.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Booster.textBody(context, Strings.Please_enter_the_location_data.tr, color: LightColors.PRIMARY_COLOR),
            Booster.verticalSpace(15),
            TextField(
              maxLines: 1,
              controller: controller.nameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                  errorStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.redAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: Strings.Indicativ_name_site.tr,
                  hintStyle: TextStyle(color: LightColors.TEXT_HINT_COLOR, fontSize: 14.0),
                  filled: true,
                  fillColor: LightColors.EDIT_BACKGROUND_COLOR,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: LightColors.EDIT_BORDER_FOCUSED_COLOR ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    //borderSide: BorderSide(color: Colors.white),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  )),
            ),
            Booster.verticalSpace(15),
            Expanded(
              child: GetBuilder<UserAddLocationController>(
                  id: "map",
                  builder: (context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        markers: controller.markers,
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
                          }catch(e){
                            Logger().e(e);
                          }
                        },
                        myLocationEnabled: true,
                      ),
                    );
                  }
              ),
            ),
            Booster.verticalSpace(15),
            Material(
              child: InkWell(
                onTap: ()=> controller.save(),
                borderRadius:
                BorderRadius.circular(7),
                child: Ink(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0),
                  decoration: BoxDecoration(
                    color: LightColors.PRIMARY_COLOR,
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
            Booster.verticalSpace(15),
          ],
        )
      ),
    );
  }
}
