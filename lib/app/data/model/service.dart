import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../modules/user/home/controllers/home_controller.dart';
import 'currency.dart';

class Service {
  int? id;
  String? serviceEn;
  String? serviceAr;
  String? price;
  String? idProgram;
  String? createdAt;
  String? updatedAt;
  late bool selected;

  Service(
      {this.id,
        this.serviceEn,
        this.serviceAr,
        this.price,
        this.idProgram,
        this.selected = false,
        this.createdAt,
        this.updatedAt});


  double getPrice(coins, coinsNameAr, coinsNameEn){

    final userCurrency = Get.find<HomeController>().userCurrency;
    if(userCurrency == null){
      return int.parse(price!).toDouble();
    }

    try {
      final currencyList = Get.find<HomeController>().currencyList;
      Currency? compCurrency;

      if(coins != null){
        try {
          compCurrency = currencyList.firstWhere((element) => element.coinsNameEn == coins);
        }catch(_){
          compCurrency = currencyList.firstWhere((element) => element.coinsNameAr == coins);
        }

      }else if (coinsNameEn == null) {
        // lang is en
        compCurrency = currencyList.firstWhere((element) => element.coinsNameEn == coinsNameAr);
      } else {
        // lang is ar
        compCurrency = currencyList.firstWhere((element) => element.coinsNameAr == coinsNameAr);
      }


      if(userCurrency.id == compCurrency.id){

        return int.parse(price!).toDouble();
      }else{
        return (int.parse(price!) * compCurrency.dollar!.toDouble()) / userCurrency.dollar!;
      }

    }catch(e){
      Logger().e(e.toString());
      return int.parse(price!).toDouble();
    }

  }


  Service.fromJson(Map<String, dynamic> json) {
    selected = false;
    id = json['id'];
    serviceEn = json['service_en'];
    serviceAr = json['service_ar'];
    price = json['price'];
    idProgram = json['id_program'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_en'] = serviceEn;
    data['service_ar'] = serviceAr;
    data['price'] = price;
    data['id_program'] = idProgram;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}