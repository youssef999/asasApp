import 'dart:async';


import 'package:asas/app/data/model/company.dart';

import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class SharedMapController extends GetxController {

  // completer to help with map initializing and creating (map controller)

  late Completer<GoogleMapController> mapCompleter;


  // map controller (to animate camera and update position)

  GoogleMapController? googleMapController;


  // default position when user first open map it will point to (gaza)

  // but it will be updated when we get user location via location service

  late CameraPosition cameraPosition;


  // marker for the current chalet location

  late Set<Marker> markers;


  late Company company;


  Set<Marker> createMarkers() {

    // Create a set to hold the markers

    Set<Marker> markers = {};

    company = Get.arguments[0];

    double latitude = 31.505;

    double longitude = 34.440;

    // Add markers to the set

    if (company.lat != null) {

      latitude = double.parse(company.lat!);

    }


    if (company.lng != null) {

      longitude = double.parse(company.lng!);

    }

    cameraPosition = CameraPosition(

        target: LatLng(

          latitude,

          longitude,

        ),

        zoom: 15);
    print("GXT $latitude");

    markers.add(

      Marker(
        markerId: MarkerId('company_location'),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: 'Marker 1'),
      ),

    );


    // Add more markers as needed


    return markers;

  }


  @override

  void onInit() {

    mapCompleter = Completer();


    createMarkers();


    super.onInit();

  }


  @override

  void onClose() {

    try {

      googleMapController?.dispose();

    } catch (error) {}

    super.onClose();

  }

}

