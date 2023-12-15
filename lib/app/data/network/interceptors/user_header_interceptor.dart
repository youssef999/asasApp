import 'dart:async';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:chopper/chopper.dart';

class UserHeaderInterceptor implements RequestInterceptor  {
  static const String AUTH_HEADER_1 = "content-type";
  static const String AUTH_HEADER_2 = "accept";
  static const String VALUE = "application/json";

  static const String AUTH_HEADER = "Authorization";
  static const String BEARER = "Bearer ";

  @override
  FutureOr<Request> onRequest(Request request) async {
    final token = PreferenceUtils.getUserData()?.accessToken ?? '';
    Request newRequest = request.copyWith(
        headers:
        {
          AUTH_HEADER: BEARER + token,
          AUTH_HEADER_1: VALUE,
          AUTH_HEADER_2: VALUE
        });
    return newRequest;
  }


}