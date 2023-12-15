import 'dart:async';

import 'package:asas/app/helpers/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../translations/strings_enum.dart';

class OwnerAddLocationController extends GetxController {
// completer to help with map initializing and creating (map controller)
  Completer<GoogleMapController> mapCompleter = Completer();

  // map controller (to animate camera and update position)
  GoogleMapController? googleMapController;

  // default position when user first open map it will point to (gaza)
  // but it will be updated when we get user location via location service
  late CameraPosition cameraPosition ;

  // location service to get user current location
  Location location = Location();

  // if location service started successfully
  bool serviceEnabled = false;

  // check if user granted permission to use location
  bool permissionGranted = false;

  // user location (will be set if the location service worked fine and we got user location else it will remain null)
  LocationData? locationData;

  // check if current location being send to api (loading)
  var currentLocationSendingToApi = false;

  // check if current location has been sent to api (don't send again)
  var currentLocationSentToApi = false;

  // for custom marker (image as marker
  late BitmapDescriptor bitmapDescriptor;


  // markers of the nearby sections on map
  Set<Marker> markers = <Marker>{};

  onMapTap(LatLng value){
    markers.clear();
    markers.add(
      Marker(
        onTap: (){},
        position: LatLng(value.latitude ,value.longitude,),
        markerId: MarkerId("1"),
      ),
    );
    update(['map']);
  }

  save(){
    if(markers.isEmpty){
      CustomLoading.showWrongToast(msg: Strings.No_detect_location.tr);
      return;
    }
    Get.back(result: {
      "latitude" : markers.first.position.latitude.toStringAsFixed(7),
      "longitude" : markers.first.position.longitude.toStringAsFixed(7)
    });
  }


  /// initialize custom marker image (bitmap)  (75*75) is perfect size!
  initMarkerImage() async {
    bitmapDescriptor = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(110, 110),), 'assets/images/worker.png');
  }

  /// initialize location service to get user current location
  initLocationService() async {
    // *) start location service
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return; // stop function if sth wrong went with service
      }
    }

    // *) check if user granted permission to use location
    var permissionStatus = (await location.hasPermission());
    permissionGranted = permissionStatus == PermissionStatus.granted || permissionStatus == PermissionStatus.grantedLimited;
    if (!permissionGranted) {
      var per = await location.requestPermission();
      permissionGranted =  per == PermissionStatus.granted || per == PermissionStatus.grantedLimited;
      if (!permissionGranted) {
        return;
      }
    }

    // *) user location data (current location & other info)
    locationData = await location.getLocation();

    // *) send user location to api
    if(locationData!.latitude != null && locationData!.longitude != null){


    }

    // *) keep listening to user location
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //
    // });
  }



  @override
  void onInit() {
    super.onInit();

    double longitude = double.parse(Get.arguments[0] ?? "45.8475");
    double latitude = double.parse(Get.arguments[1] ?? "24.7947");

    onMapTap(LatLng(latitude, longitude,));
    cameraPosition = CameraPosition(target: LatLng(latitude, longitude,),zoom: 5);

    initLocationService();
  }

  @override
  void onClose() {
    googleMapController!.dispose();
  }

}
