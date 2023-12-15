// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_service.dart';

// **************************************************************************

// ChopperGenerator

// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps

class _$UserService extends UserService {
  _$UserService([ChopperClient? client]) {
    if (client == null) return;

    this.client = client;
  }

  @override
  final definitionType = UserService;

  @override
  Future<Response<dynamic>> getStudents() {
    final $url = '/fathers/children/myChildren';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteStudents(int id) {
    final $url = '/fathers/children/destroy/id/${id}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addStudents(
      String name,
      String name_father,
      String date_of_birth,
      String gender,
      String nationality,
      String country_of_residence,
      String id_curriculum_type,
      String current_academic_certificates,
      String sports_of_interest,
      String artistic_activities_of_interest,
      String religious_activities_of_interest,
      List<String> images) {
    final $url = '/fathers/children/create';

    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $parts = <PartValue>[
      PartValue<String>('name', name),
      PartValue<String>('name_father', name_father),
      PartValue<String>('date_of_birth', date_of_birth),
      PartValue<String>('gender', gender),
      PartValue<String>('nationality', nationality),
      PartValue<String>('country_of_residence', country_of_residence),
      PartValue<String>('id_curriculum_type', id_curriculum_type),
      PartValue<String>(
          'current_academic_certificates', current_academic_certificates),
      PartValue<String>('sports_of_interest', sports_of_interest),
      PartValue<String>(
          'artistic_activities_of_interest', artistic_activities_of_interest),
      PartValue<String>(
          'religious_activities_of_interest', religious_activities_of_interest),
      ...images
          .map(
            (e) => PartValueFile<String>('img[${images.indexOf(e)}]', e),
          )
          .toList()
    ];

    final $request = Request('POST' ,Uri.parse($url.toString()), client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateStudents(
      int id,
      String name,
      String name_father,
      String date_of_birth,
      String gender,
      String nationality,
      String country_of_residence,
      String id_curriculum_type,
      String current_academic_certificates,
      String sports_of_interest,
      String artistic_activities_of_interest,
      String religious_activities_of_interest) {
    final $url = '/fathers/children/update/id/${id}';

    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $body = <String, dynamic>{
      'name': name,
      'name_father': name_father,
      'date_of_birth': date_of_birth,
      'gender': gender,
      'nationality': nationality,
      'country_of_residence': country_of_residence,
      'id_curriculum_type': id_curriculum_type,
      'current_academic_certificates': current_academic_certificates,
      'sports_of_interest': sports_of_interest,
      'artistic_activities_of_interest': artistic_activities_of_interest,
      'religious_activities_of_interest': religious_activities_of_interest
    };

    final $request =
        Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body, headers: $headers);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStudentById(int id) {
    final $url = '/children/single/id/${id}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCountries() {
    final $url = '/setting/country';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCity(int id) {
    final $url = '/setting/city/mycountry/${id}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDistrict(int id) {
    final $url = '/setting/area/mycity/${id}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addMedia(
      String id_, String tableName, String media) {
    final $url = '/media/save';

    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $parts = <PartValue>[
      PartValue<String>('id_', id_),
      PartValue<String>('table_name', tableName),
      PartValueFile<String>('media[0]', media)
    ];

    final $request = Request('POST' ,Uri.parse($url.toString()), client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteMedia(int id) {
    final $url = '/media_destroy/id/${id}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCompaniesByCountryAndCityId(
      String countryId, String cityId, int page) {
    final $url =
        '/companydata/filter/id_country/${countryId}/id_city/${cityId}';

    final $params = <String, dynamic>{'page': page};

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCompaniesByToken(int page) {
    final $url = '/companydata/filter/country_city';

    final $params = <String, dynamic>{'page': page};

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCompanyByIdWithFav(int id, int idFather) {
    final $url = '/companydata/id/${id}/${idFather}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCompanyById(int id) {
    final $url = '/companydata/id/${id}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCompaniesByCategoryId(
      int categoryId, String idCity, int page) {
    final $url =
        '/companydata/filter/id_company_type/${categoryId}/id_city/${idCity}';

    final $params = <String, dynamic>{'page': page};

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getChat(int companyId, int fatherId) {
    final $url = '/chat/my/id_company/${companyId}/id_father/${fatherId}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> sendMessage(
      int companyId, int fatherId, String message, String sender) {
    final $url = '/chat/send';

    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $body = <String, dynamic>{
      'id_company': companyId,
      'id_father': fatherId,
      'message': message,
      'sender': sender
    };

    final $request =
        Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body, headers: $headers);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addComment(int companyId, String message) {
    final $url = '/fathers/opinion';

    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $body = <String, dynamic>{
      'id_company': companyId,
      'opinion': message
    };

    final $request =
        Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body, headers: $headers);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getComments(int companyId, int page) {
    final $url = '/opinions/id_company/${companyId}';

    final $params = <String, dynamic>{'page': page};

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addStudentToProgram(
      String childIds, int programId, String serviceIds) {
    final $url = '/fathers/children/reservation/create';

    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $body = <String, dynamic>{
      'id_child': childIds,
      'id_program': programId,
      'id_service': serviceIds
    };

    final $request =
        Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body, headers: $headers);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyBooking(int page) {
    final $url = '/fathers/children/reservation/my';

    final $params = <String, dynamic>{'page': page};

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteBooking(int id) {
    final $url = '/fathers/children/reservation/my/delete/id/${id}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStudentsNotReserved(int id) {
    final $url = '/fahters/children/not_register/id_program/${id}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getChatList() {
    final $url = '/chat/my/main';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRate(int id) {
    final $url = '/companydata_rate/id_company/${id}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addRate(
      int idCompany,
      double scientificLevel,
      double activityLevel,
      double buildingsAndStadiums,
      double attentionAndCommunication,
      double disciplineAndCleanliness) {
    final $url = '/companydata_rate';

    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $body = <String, dynamic>{
      'id_company': idCompany,
      'scientific_level': scientificLevel,
      'activity_level': activityLevel,
      'buildings_and_stadiums': buildingsAndStadiums,
      'attention_and_communication': attentionAndCommunication,
      'discipline_and_cleanliness': disciplineAndCleanliness
    };

    final $request =
        Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body, headers: $headers);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> companySearch(
      String query, int page, String cityId) {
    final $url = '/companydata/likeSearch/${query}/${cityId}';

    final $params = <String, dynamic>{'page': page};

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> companyCategorySearch(
      String query, int categoryId, int page, String cityId) {
    final $url = '/companydata/likeSearch/${query}/${cityId}/${categoryId}';

    final $params = <String, dynamic>{'page': page};

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllCompany(int page, String idCity) {
    final $url = '/companydata_all/id_city/${idCity}/type_sort/rate';

    final $params = <String, dynamic>{'page': page};

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getTopRatedCompany(int page, String cityId) {
    final $url = '/companydata_all/id_city/${cityId}/type_sort/rate';

    final $params = <String, dynamic>{'page': page};

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCompanyByLocation(
      String latitude, String longitude, int page, String cityId) {
    final $url = '/companydata_all/sort/location/home/id_city/${cityId}';

    final $params = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'page': page
    };

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> programsSearch(
      String query, int categoryId, String idCity, int page) {
    final $url =
        '/programs/id_type_program/${categoryId}/id_city/${idCity}/${query}';

    final $params = <String, dynamic>{'page': page};

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getNotification(int page) {
    final $url = '/getnotification_father_read_and_noteRead';

    final $params = <String, dynamic>{'page': page};

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getNotificationCount() {
    final $url = '/count-notification_father_not_read';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addFavorite(int idCompany) {
    final $url = '/favorate/save/${idCompany}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteFavorite(int favoriteId) {
    final $url = '/favorate/delete/${favoriteId}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFavorite(int page) {
    final $url = '/favorate/get';

    final $params = <String, dynamic>{'page': page};

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getProfile() {
    final $url = '/father';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateProfile(
      String name, String phone, int idCountry, int idCity, int idCoins) {
    final $url = '/father/update';

    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $body = <String, dynamic>{
      'name': name,
      'phone': phone,
      'id_country': idCountry,
      'id_city': idCity,
      'id_coins': idCoins
    };

    final $request =
        Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body, headers: $headers);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCountNotRead(int idCompany, int idFather) {
    final $url = '/countNotRead/id_company/${idCompany}/id_father/${idFather}';

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getDistricts(
      String countryId, String cityId, int page, int sort, int id) {
    final $url =
        '/companydata/filter/id_country/${countryId}/id_city/${cityId}';

    final $params = <String, dynamic>{
      'page': page,
      'sort': sort,
      'id_district': id
    };

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getNewest(
      String countryId, String cityId, int page, int id, int district) {
    final $url =
        '/companydata/filter/id_country/${countryId}/id_city/${cityId}';

    final $params = <String, dynamic>{
      'page': page,
      'sort': id,
      'id_district': district
    };

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getClosest(String countryId, String cityId, int page, int id,
      String latitude, String longitude, int district) {
    final $url =
        '/companydata/filter/id_country/${countryId}/id_city/${cityId}';

    final $params = <String, dynamic>{
      'page': page,
      'sort': id,
      'latitude': latitude,
      'longitude': longitude,
      'id_district': district
    };

    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);

    return client.send<dynamic, dynamic>($request);
  }
}
