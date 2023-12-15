// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portal_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$PortalService extends PortalService {
  _$PortalService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PortalService;

  @override
  Future<Response<dynamic>> getPrograms(int userId, int page) {
    final $url = '/programs/all/id_facility_owner/${userId}';
    final $params = <String, dynamic>{'page': page};
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> copyProgram(int id) {
    final $url = '/programs/copy/id/${id}';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getTimeTypes() {
    final $url = '/time_types/all';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getProgramTypes() {
    final $url = '/program_types/all';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addProgram(
      String nameEn,
      String nameAr,
      String descriptionEn,
      String descriptionAr,
      String idTimetype,
      String idTypeprogram,
      String priceMain,
      String ageConditionsEn,
      String ageConditionsAr,
      String otherConditionsEn,
      String otherConditionsAr,
      String priceNoteAr,
      String priceNoteEn,
      String otherFute,
      String urlViedo,
      String idCurriculumType,
      String discount,
      String serviceMore,
      List<String> images) {
    final $url = '/programs/save';
    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $parts = <PartValue>[
      PartValue<String>('name_en', nameEn),
      PartValue<String>('name_ar', nameAr),
      PartValue<String>('description_en', descriptionEn),
      PartValue<String>('description_ar', descriptionAr),
      PartValue<String>('id_timeType', idTimetype),
      PartValue<String>('id_typeProgram', idTypeprogram),
      PartValue<String>('price_main', priceMain),
      PartValue<String>('age_conditions_en', ageConditionsEn),
      PartValue<String>('age_conditions_ar', ageConditionsAr),
      PartValue<String>('other_conditions_en', otherConditionsEn),
      PartValue<String>('other_conditions_ar', otherConditionsAr),
      PartValue<String>('price_note_ar', priceNoteAr),
      PartValue<String>('price_note_en', priceNoteEn),
      PartValue<String>('other_fute', otherFute),
      PartValue<String>('url_viedo', urlViedo),
      PartValue<String>('id_curriculum_type', idCurriculumType),
      PartValue<String>('discount', discount),
      PartValue<String>('service_more', serviceMore),
      ...images.map((e) => PartValueFile<String>('image[${images.indexOf(e)}]', e),).toList()

    ];
    final $request = Request('POST' ,Uri.parse($url.toString()), client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteProgram(int id) {
    final $url = '/programs_destroy/id/${id}';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getProgramById(int id) {
    final $url = '/programs/id/${id}';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getProgramComById(int id) {
    final $url = '/programs-withFacility/id/${id}';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateProgram(
      int id,
      String nameEn,
      String nameAr,
      String descriptionEn,
      String descriptionAr,
      String idTimetype,
      String idTypeprogram,
      String priceMain,
      String ageConditionsEn,
      String ageConditionsAr,
      String otherConditionsEn,
      String otherConditionsAr,
      String priceNoteAr,
      String priceNoteEn,
      String otherFute,
      String urlViedo,
      String idCurriculumType) {
    final $url = '/programs/update/id/${id}';
    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $body = <String, dynamic>{
      'name_en': nameEn,
      'name_ar': nameAr,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'id_timeType': idTimetype,
      'id_typeProgram': idTypeprogram,
      'price_main': priceMain,
      'age_conditions_en': ageConditionsEn,
      'age_conditions_ar': ageConditionsAr,
      'other_conditions_en': otherConditionsEn,
      'other_conditions_ar': otherConditionsAr,
      'price_note_ar': priceNoteAr,
      'price_note_en': priceNoteEn,
      'other_fute': otherFute,
      'url_viedo': urlViedo,
      'id_curriculum_type': idCurriculumType
    };
    final $request =
        Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCurriculum() {
    final $url = '/curriculum/all';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addDiscount(
      String programId, String priceDiscount, String start, String end) {
    final $url = '/program/discountSave';
    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $body = <String, dynamic>{
      'id_program': programId,
      'price_rate_discount': priceDiscount,
      'start_discount': start,
      'end_discount': end
    };
    final $request =
        Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addService(
      String programId, String price, String serviceAr, String serviceEn) {
    final $url = '/service_more/save';
    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $body = <String, dynamic>{
      'id_program': programId,
      'price': price,
      'service_ar': serviceAr,
      'service_en': serviceEn
    };
    final $request =
        Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body, headers: $headers);
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
  Future<Response<dynamic>> deleteService(int id) {
    final $url = '/service_more/destory/id/${id}';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteDiscount(int id) {
    final $url = '/program/discountDestroy/id/${id}';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyCompany() {
    final $url = '/my_companydata_singl';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAgreements() {
    final $url = '/agreements/facility_owner';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCurrency() {
    final $url = '/setting/coins';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateCurrency(int id) {
    final $url = '/companydata/update_languege_coin';
    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $body = <String, dynamic>{'id_coins': id};
    final $request =
        Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  // @override
  // Future<Response<dynamic>> updateCompany(
  //     int id,
  //     String name_corporation,
  //     String name_corporation_ar,
  //     String desception_ar,
  //     String desception_en,
  //     String lat,
  //     String lng,
  //     String id_country,
  //     String id_district,
  //     String id_city,
  //     String id_coins,
  //     String id_company_type,
  //     String logo) {
  //   final $url = '/companydata_update/id/${id}';
  //   final $headers = {
  //     'Content-Type': 'multipart/form-data',
  //   };

  //   final $parts = <PartValue>[
  //     PartValue<String>('name_corporation', name_corporation),
  //     PartValue<String>('name_corporation_ar', name_corporation_ar),
  //     PartValue<String>('desception_ar', desception_ar),
  //     PartValue<String>('desception_en', desception_en),
  //     PartValue<String>('lat', lat),
  //     PartValue<String>('lng', lng),
  //     PartValue<String>('id_country', id_country),
  //     PartValue<String>('id_city', id_city),
  //     PartValue<String>('id_district', id_district),
  //     PartValue<String>('id_coins', id_coins),
  //     PartValue<String>('id_company_type', id_company_type),
  //     if(logo.isNotEmpty)
  //     PartValueFile<String>('logo', logo)
  //   ];
  //   final $request = Request('POST' ,Uri.parse($url.toString()), client.baseUrl,
  //       parts: $parts, multipart: true, headers: $headers);
  //   return client.send<dynamic, dynamic>($request);
  // }

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
  Future<Response<dynamic>> getCompanyTypes() {
    final $url = '/company_types/all';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getReservation() {
    final $url = '/company/children/reservation/my';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getReservationByStatusId(int statusId) {
    final $url = '/company/children/reservation/my/singleStatus/${statusId}';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getReservationStatus() {
    final $url = '/reservation_status/all';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateReservationStatus(
      int childrenProgramId, int reservationStatusesId) {
    final $url = '/update/children_program/reservation_status';
    final $headers = {
      'Content-Type': 'multipart/form-data',
    };

    final $body = <String, dynamic>{
      'id_children_program': childrenProgramId,
      'id_reservation_statuses': reservationStatusesId
    };
    final $request =
        Request('POST' ,Uri.parse($url.toString()), client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getChatList() {
    final $url = '/chat/my/main';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getReservationDetails(int reservationId) {
    final $url = '/company/children/reservation/my/single/${reservationId}';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getNotification(int page) {
    final $url = '/getnotification_facility_read_and_noteRead';
    final $params = <String, dynamic>{'page': page};
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getNotificationCount() {
    final $url = '/count-notification_facility_not_read';
    final $request = Request('GET' ,Uri.parse($url.toString()), client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
