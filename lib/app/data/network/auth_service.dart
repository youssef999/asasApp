import 'package:asas/app/helpers/constance.dart';
import 'package:chopper/chopper.dart';
import 'interceptors/auth_header_interceptor.dart';

part 'auth_service.chopper.dart';


@ChopperApi(baseUrl: "")
abstract class AuthService extends ChopperService {

  static final _client = ChopperClient(
      baseUrl: Constance.baseUrl,
      services: [_$AuthService()],
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        AuthHeaderInterceptor(),
      ]);


  @Post(path: Constance.loginUrl)
  Future<Response> login({
    @Field("name") required String name,
    @Field("password") required String password,
    @Field("device_token") required String fcmToken,
  });

  @Post(path: Constance.userLoginUrl)
  Future<Response> userLogin({
    @Field("name") required String name,
    @Field("device_token") required String fcmToken,
    @Field("password") required String password,
  });

  @Post(path: Constance.userLoginWithFacebookUrl)
  Future<Response> userLoginWithFacebookUrl({
    @Field("access_token") required String accessToken,
    @Field("device_token") required String fcmToken,
    @Field("provider_name") required String providerName,
    @Field("id_country") required String countryId,
    @Field("id_city") required String cityId,
  });


  @Post(path: Constance.ownerSignup)
  Future<Response> ownerSignup({
    @Field("name") required String name,
    @Field("device_token") required String deviceToken,
    @Field("name_corporation") required String corporationName,
    @Field("name_corporation_ar") required String corporationNameAr,
    @Field("phone") required String phone,
    @Field("password") required String password,
  });

  @Post(path: Constance.userSignup)
  Future<Response> userSignup({
    @Field("name") required String name,
    @Field("device_token") required String deviceToken,
    @Field("phone") required String phone,
    @Field("password") required String password,
    @Field("id_city") required String cityId,
    @Field("id_country") required String countryId
  });


  @Get(path: Constance.getCoinsType)
  Future<Response> getCoinsType({
    @Path("user_id") required int userId,
    @Path("type") required String type,
  });



  static AuthService create() {
    return _$AuthService(_client);
  }

}
