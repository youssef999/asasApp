import 'package:asas/app/helpers/constance.dart';
import 'package:chopper/chopper.dart';
import 'interceptors/header_interceptor.dart';

part 'portal_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class PortalService extends ChopperService {

  static final _client = ChopperClient(
      baseUrl: Constance.baseUrl,
      services: [_$PortalService()],
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        HeaderInterceptor(),
        // UrlInterceptor()
      ]);

  @Get(path: Constance.getPrograms)
  Future<Response> getPrograms(@Path('user_id') int userId, @Query('page') int page);

  @Get(path: Constance.copyProgram)
  Future<Response> copyProgram(@Path('id') int id);

  @Get(path: Constance.getTimeTypes)
  Future<Response> getTimeTypes();

  @Get(path: Constance.getProgramTypes)
  Future<Response> getProgramTypes();

  // ...images.map((e) => PartValueFile<String>('image[${images.indexOf(e)}]', e),).toList()
  @multipart
  @Post(path: Constance.addProgram, headers: {"Content-Type": "multipart/form-data",})
  Future<Response> addProgram(
        @Part('name_en') String nameEn,
        @Part('name_ar') String nameAr,
        @Part('description_en') String descriptionEn,
        @Part('description_ar') String descriptionAr,
        @Part('id_timeType') String idTimetype,
        @Part('id_typeProgram') String idTypeprogram,
        @Part('price_main') String priceMain,
        @Part('age_conditions_en') String ageConditionsEn,
        @Part('age_conditions_ar') String ageConditionsAr,
        @Part('other_conditions_en') String otherConditionsEn,
        @Part('other_conditions_ar') String otherConditionsAr,
        @Part('price_note_ar') String priceNoteAr,
        @Part('price_note_en') String priceNoteEn,
        @Part('other_fute') String otherFute,
        @Part('url_viedo') String urlViedo,
        @Part('id_curriculum_type') String idCurriculumType,
        @Part('discount') String discount,
        @Part('service_more') String serviceMore,
        @PartFile('image') List<String> images
      );

  @Get(path: Constance.deleteProgram)
  Future<Response> deleteProgram(@Path('id') int id);

  @Get(path: Constance.getProgramById)
  Future<Response> getProgramById(@Path('id') int id);

  @Get(path: Constance.getProgramComById)
  Future<Response> getProgramComById(@Path('id') int id);

  @Post(path: Constance.updateProgram, headers: {"Content-Type": "multipart/form-data",})
  Future<Response> updateProgram(
      @Path('id') int id,
      @Field('name_en') String nameEn,
      @Field('name_ar') String nameAr,
      @Field('description_en') String descriptionEn,
      @Field('description_ar') String descriptionAr,
      @Field('id_timeType') String idTimetype,
      @Field('id_typeProgram') String idTypeprogram,
      @Field('price_main') String priceMain,
      @Field('age_conditions_en') String ageConditionsEn,
      @Field('age_conditions_ar') String ageConditionsAr,
      @Field('other_conditions_en') String otherConditionsEn,
      @Field('other_conditions_ar') String otherConditionsAr,
      @Field('price_note_ar') String priceNoteAr,
      @Field('price_note_en') String priceNoteEn,
      @Field('other_fute') String otherFute,
      @Field('url_viedo') String urlViedo,
      @Field('id_curriculum_type') String idCurriculumType,
      );


  @Get(path: Constance.getCurriculum)
  Future<Response> getCurriculum();

  @Post(path: Constance.addDiscount, headers: {"Content-Type": "multipart/form-data",})
  Future<Response> addDiscount(
      @Field('id_program') String programId,
      @Field('price_rate_discount') String priceDiscount,
      @Field('start_discount') String start,
      @Field('end_discount') String end,
      );

  @Post(path: Constance.addService, headers: {"Content-Type": "multipart/form-data",})
  Future<Response> addService(
      @Field('id_program') String programId,
      @Field('price') String price,
      @Field('service_ar') String serviceAr,
      @Field('service_en') String serviceEn,
      );

  @multipart
  @Post(path: Constance.addMedia, headers: {"Content-Type": "multipart/form-data",})
  Future<Response> addMedia(
      @Part('id_') String id_,
      @Part('table_name') String tableName, //programs
      @PartFile('media[0]') String media,
      );

  @Get(path: Constance.deleteMedia)
  Future<Response> deleteMedia(@Path('id') int id);

  @Get(path: Constance.deleteService)
  Future<Response> deleteService(@Path('id') int id);

  @Get(path: Constance.deleteDiscount)
  Future<Response> deleteDiscount(@Path('id') int id);


  @Get(path: Constance.getMyCompany)
  Future<Response> getMyCompany();

  @Get(path: Constance.getAgreements)
  Future<Response> getAgreements();

  @Get(path: Constance.getCurrency)
  Future<Response> getCurrency();

  @Post(path: Constance.updateCurrency, headers: {"Content-Type": "multipart/form-data",})
  Future<Response> updateCurrency(@Field('id_coins') int id,);



  // if(logo.isNotEmpty)
  @multipart
  // @Post(path: Constance.updateCompany, headers: {"Content-Type": "multipart/form-data",})
  // Future<Response> updateCompany(
  //     @Path('id') int id,
  //     @Part('name_corporation') String name_corporation,
  //     @Part('name_corporation_ar') String name_corporation_ar,
  //     @Part('desception_ar') String desception_ar,
  //     @Part('desception_en') String desception_en,
  //     @Part('lat') String lat,
  //     @Part('lng') String lng,
  //     @Part('id_country') String id_country,
  //     @Part('id_district') String id_district,
  //     @Part('id_city') String id_city,
  //     @Part('id_coins') String id_coins,
  //     @Part('id_company_type') String id_company_type,
  //     @PartFile('logo') String logo
  //     );


  @Get(path: Constance.getChat)
  Future<Response> getChat(@Path('id_company') int companyId, @Path('id_father') int fatherId);

  @Post(path: Constance.sendMessage, headers: {"Content-Type": "multipart/form-data",})
  Future<Response> sendMessage(
      @Field('id_company') int companyId,
      @Field('id_father') int fatherId,
      @Field('message') String message,
      @Field('sender') String sender,
      );

  @Get(path: Constance.getCompanyTypes)
  Future<Response> getCompanyTypes();

  @Get(path: Constance.getReservation)
  Future<Response> getReservation();

  @Get(path: Constance.getReservationByStatusId)
  Future<Response> getReservationByStatusId(@Path('id') int statusId);

  @Get(path: Constance.getReservationStatus)
  Future<Response> getReservationStatus();

  @Post(path: Constance.updateReservationStatus, headers: {"Content-Type": "multipart/form-data",})
  Future<Response> updateReservationStatus(
      @Field('id_children_program') int childrenProgramId,
      @Field('id_reservation_statuses') int reservationStatusesId,
      );

  @Get(path: Constance.getChatList)
  Future<Response> getChatList();

  @Get(path: Constance.getReservationDetails)
  Future<Response> getReservationDetails(@Path('id') int reservationId);

  @Get(path: Constance.getComNotification)
  Future<Response> getNotification(@Query('page') int page,);

  @Get(path: Constance.getComNotificationCount)
  Future<Response> getNotificationCount();

  static PortalService create() {
    return _$PortalService(_client);
  }

}
