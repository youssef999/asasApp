import 'package:asas/app/helpers/constance.dart';
import 'package:chopper/chopper.dart';

import 'interceptors/user_header_interceptor.dart';

part 'user_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class UserService extends ChopperService {
  static final _client = ChopperClient(
      baseUrl: Constance.baseUrl,
      services: [_$UserService()],
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        UserHeaderInterceptor(),
        // UrlInterceptor()
      ]);

  @Get(path: Constance.getStudents)
  Future<Response> getStudents();

  @Get(path: Constance.deleteStudents)
  Future<Response> deleteStudents(@Path('id') int id);

  // ...images.map((e) => PartValueFile<String>('img[${images.indexOf(e)}]', e),).toList()
  @multipart
  @Post(path: Constance.addStudents, headers: {
    "Content-Type": "multipart/form-data",
  })
  Future<Response> addStudents(
      @Part('name') String name,
      @Part('name_father') String name_father,
      @Part('date_of_birth') String date_of_birth,
      @Part('gender') String gender,
      @Part('nationality') String nationality,
      @Part('country_of_residence') String country_of_residence,
      @Part('id_curriculum_type') String id_curriculum_type,
      @Part('current_academic_certificates')
      String current_academic_certificates,
      @Part('sports_of_interest') String sports_of_interest,
      @Part('artistic_activities_of_interest')
      String artistic_activities_of_interest,
      @Part('religious_activities_of_interest')
      String religious_activities_of_interest,
      @PartFile('img') List<String> images);

  @Post(path: Constance.updateStudents, headers: {
    "Content-Type": "multipart/form-data",
  })
  Future<Response> updateStudents(
    @Path('id') int id,
    @Field('name') String name,
    @Field('name_father') String name_father,
    @Field('date_of_birth') String date_of_birth,
    @Field('gender') String gender,
    @Field('nationality') String nationality,
    @Field('country_of_residence') String country_of_residence,
    @Field('id_curriculum_type') String id_curriculum_type,
    @Field('current_academic_certificates')
    String current_academic_certificates,
    @Field('sports_of_interest') String sports_of_interest,
    @Field('artistic_activities_of_interest')
    String artistic_activities_of_interest,
    @Field('religious_activities_of_interest')
    String religious_activities_of_interest,
  );

  @Get(path: Constance.getStudentById)
  Future<Response> getStudentById(@Path('id') int id);

  @Get(path: Constance.getCountries)
  Future<Response> getCountries();

  @Get(path: Constance.getCity)
  Future<Response> getCity(@Path('id') int id);

  @Get(path: Constance.getDistrict)
  Future<Response> getDistrict(@Path('id') int id);

  @multipart
  @Post(path: Constance.addMedia, headers: {
    "Content-Type": "multipart/form-data",
  })
  Future<Response> addMedia(
    @Part('id_') String id_,
    @Part('table_name') String tableName, //programs
    @PartFile('media[0]') String media,
  );

  @Get(path: Constance.deleteMedia)
  Future<Response> deleteMedia(@Path('id') int id);

  @Get(path: Constance.getCompaniesByCountryAndCityId)
  Future<Response> getCompaniesByCountryAndCityId(
      @Path('id_country') String countryId,
      @Path('id_city') String cityId,
      @Query('page') int page);

  @Get(path: Constance.getCompaniesByCountryAndCityId)
  Future<Response> getDistricts(
      @Path('id_country') String countryId,
      @Path('id_city') String cityId,
      @Query('page') int page,
      @Query('sort') int sort,
      @Query('id_district') int id);

  @Get(path: Constance.getCompaniesByCountryAndCityId)
  Future<Response> getNewest(
      @Path('id_country') String countryId,
      @Path('id_city') String cityId,
      @Query('page') int page,
      @Query('sort') int id,
  @Query('id_district')
  int district);

  @Get(path: Constance.getCompaniesByCountryAndCityId)
  Future<Response> getClosest(
      @Path('id_country') String countryId,
      @Path('id_city') String cityId,
      @Query('page') int page,
      @Query('sort') int id,
      @Query('latitude') String latitude,
      @Query('longitude') String longitude,@Query('id_district') int district,);

  @Get(path: Constance.getCompaniesByToken)
  Future<Response> getCompaniesByToken(@Query('page') int page);

  @Get(path: Constance.getCompanyByIdWithFav)
  Future<Response> getCompanyByIdWithFav(
      @Path('id') int id, @Path('id_father') int idFather);

  @Get(path: Constance.getCompanyById)
  Future<Response> getCompanyById(@Path('id') int id);

  @Get(path: Constance.getCompaniesByCategoryId)
  Future<Response> getCompaniesByCategoryId(@Path('id') int categoryId,
      @Path('id_city') String idCity, @Query('page') int page);

  @Get(path: Constance.getChat)
  Future<Response> getChat(
      @Path('id_company') int companyId, @Path('id_father') int fatherId);

  @Post(path: Constance.sendMessage, headers: {
    "Content-Type": "multipart/form-data",
  })
  Future<Response> sendMessage(
    @Field('id_company') int companyId,
    @Field('id_father') int fatherId,
    @Field('message') String message,
    @Field('sender') String sender,
  );

  @Post(path: Constance.addComment, headers: {
    "Content-Type": "multipart/form-data",
  })
  Future<Response> addComment(
    @Field('id_company') int companyId,
    @Field('opinion') String message,
  );

  @Get(path: Constance.getComments)
  Future<Response> getComments(
      @Path('id') int companyId, @Query('page') int page);

  @Post(path: Constance.addStudentToProgram, headers: {
    "Content-Type": "multipart/form-data",
  })
  Future<Response> addStudentToProgram(
    @Field('id_child') String childIds,
    @Field('id_program') int programId,
    @Field('id_service') String serviceIds,
  );

  @Get(path: Constance.getMyBooking)
  Future<Response> getMyBooking(@Query('page') int page);

  @Get(path: Constance.deleteBooking)
  Future<Response> deleteBooking(@Path('id') int id);

  @Get(path: Constance.getStudentsNotReserved)
  Future<Response> getStudentsNotReserved(@Path('id') int id);

  @Get(path: Constance.getChatList)
  Future<Response> getChatList();

  @Get(path: Constance.getRate)
  Future<Response> getRate(@Path('id') int id);

  @Post(path: Constance.addRate, headers: {
    "Content-Type": "multipart/form-data",
  })
  Future<Response> addRate(
    @Field('id_company') int idCompany,
    @Field('scientific_level') double scientificLevel,
    @Field('activity_level') double activityLevel,
    @Field('buildings_and_stadiums') double buildingsAndStadiums,
    @Field('attention_and_communication') double attentionAndCommunication,
    @Field('discipline_and_cleanliness') double disciplineAndCleanliness,
  );

  @Get(path: Constance.companySearch)
  Future<Response> companySearch(@Path('query') String query,
      @Query('page') int page, @Path("city_id") String cityId);

  @Get(path: Constance.companyCategorySearch)
  Future<Response> companyCategorySearch(
      @Path('query') String query,
      @Path('id') int categoryId,
      @Query('page') int page,
      @Path("city_id") String cityId);

  @Get(path: Constance.getAllCompany)
  Future<Response> getAllCompany(
      @Query('page') int page, @Path("id_city") String idCity);

  @Get(path: Constance.getTopRatedCompany)
  Future<Response> getTopRatedCompany(
      @Query('page') int page, @Path("id_city") String cityId);

  @Get(path: Constance.getCompanyByLocation)
  Future<Response> getCompanyByLocation(
      @Query('latitude') String latitude,
      @Query('longitude') String longitude,
      @Query('page') int page,
      @Path('city_id') String cityId);

  @Get(path: Constance.programsSearch)
  Future<Response> programsSearch(
      @Path('query') String query,
      @Path('id') int categoryId,
      @Path('id_city') String idCity,
      @Query('page') int page);

  @Get(path: Constance.getNotification)
  Future<Response> getNotification(
    @Query('page') int page,
  );

  @Get(path: Constance.getNotificationCount)
  Future<Response> getNotificationCount();

  @Get(path: Constance.addFavorite)
  Future<Response> addFavorite(@Path('id_company') int idCompany);

  @Get(path: Constance.deleteFavorite)
  Future<Response> deleteFavorite(@Path('favorite_id') int favoriteId);

  @Get(path: Constance.getFavorite)
  Future<Response> getFavorite(@Query('page') int page);

  @Get(path: Constance.getProfile)
  Future<Response> getProfile();

  @Post(path: Constance.updateProfile, headers: {
    "Content-Type": "multipart/form-data",
  })
  Future<Response> updateProfile(
    @Field('name') String name,
    @Field('phone') String phone,
    @Field('id_country') int idCountry,
    @Field('id_city') int idCity,
    @Field('id_coins') int idCoins,
  );

  @Get(path: Constance.getCountNotRead)
  Future<Response> getCountNotRead(
    @Path('id_company') int idCompany,
    @Path('id_father') int idFather,
  );

  static UserService create() {
    return _$UserService(_client);
  }
}
