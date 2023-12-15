// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$AuthService extends AuthService {
  _$AuthService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthService;

  @override
  Future<Response<dynamic>> login(
      {required String name,
      required String password,
      required String fcmToken}) {
    final $url = '/facility_owners/login';
    final $body = <String, dynamic>{
      'name': name,
      'password': password,
      'device_token': fcmToken
    };
    final $request = Request('POST', Uri.parse($url.toString()), client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> userLogin(
      {required String name,
      required String fcmToken,
      required String password}) {
    final $url = '/fathers/login';
    final $body = <String, dynamic>{
      'name': name,
      'device_token': fcmToken,
      'password': password
    };
    final $request = Request('POST', Uri.parse($url.toString()),
     client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> userLoginWithFacebookUrl(
      {required String accessToken,
      required String fcmToken,
      required String providerName,
      required String countryId,
      required String cityId}) {
    final $url = '/social/login/father';
    final $body = <String, dynamic>{
      'access_token': accessToken,
      'device_token': fcmToken,
      'provider_name': providerName,
      'id_country': countryId,
      'id_city': cityId
    };
    final $request = Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> ownerSignup(
      {required String name,
      required String deviceToken,
      required String corporationName,
      required String corporationNameAr,
      required String phone,
      required String password}) {
    final $url = '/facility_owners';
    final $body = <String, dynamic>{
      'name': name,
      'device_token': deviceToken,
      'name_corporation': corporationName,
      'name_corporation_ar': corporationNameAr,
      'phone': phone,
      'password': password
    };
    final $request = Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> userSignup(
      {required String name,
      required String deviceToken,
      required String phone,
      required String password,
      required String cityId,
      required String countryId}) {
    final $url = '/fathers/register';
    final $body = <String, dynamic>{
      'name': name,
      'device_token': deviceToken,
      'phone': phone,
      'password': password,
      'id_city': cityId,
      'id_country': countryId
    };
    final $request = Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCoinsType(
      {required int userId, required String type}) {
    final $url = '/coins/id_user/${userId}/type/${type}';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
