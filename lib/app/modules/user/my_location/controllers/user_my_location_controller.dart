import 'package:asas/app/data/model/my_location.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';


class UserMyLocationController extends GetxController {


  List<MyLocation> locations = [];

  onSelect(int index) {
    for(var item in locations){
      item.isSelected = false;
    }
    locations[index].isSelected = true;
    PreferenceUtils.setMyLocationList(locations);
    getLocations();
  }

  getLocations() {
    final list = PreferenceUtils.getMyLocations();
    if(list != null){
      locations = list;
      update();
    }
  }

  addLocation() async{
    await Get.toNamed(Routes.USER_ADD_LOCATION);
    getLocations();
  }

  deleteLocation(int id) async{
    PreferenceUtils.deleteLocations(id);
    getLocations();

  }


  @override
  void onInit() {
    getLocations();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
