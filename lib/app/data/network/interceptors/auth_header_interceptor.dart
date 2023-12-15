import 'dart:async';
import 'package:chopper/chopper.dart';

class AuthHeaderInterceptor implements RequestInterceptor  {
  static const String AUTH_HEADER_1 = "content-type";
  static const String AUTH_HEADER_2 = "accept";
  static const String VALUE_1 = "application/json";
  static const String VALUE_2 = "multipart/form-data";


  @override
  FutureOr<Request> onRequest(Request request) async {
    Request newRequest = request.copyWith(headers: {AUTH_HEADER_1: VALUE_1, AUTH_HEADER_2: VALUE_2});
    return newRequest;
  }


}