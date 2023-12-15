enum ApiCallStatus {
  loading,
  success,
  failed,
  empty,
  holding, // to show sth on ui before the request is even performing
}

class ReservationStatus {
  static const confirmedWithBatch = 5;
  static const canceled  = 4;
  static const rejected  = 3;
  static const acceptable  = 2;
  static const underStudying  = 1;
}


class Constance {

  static Uri baseUrl = Uri.parse('https://admin.asas-app.com/api');
  static const termsAndConditions = 'https://asas-app.com/TermsAndConditions';
  // static const baseUrl = 'https://glory.wpgooal.com/ASAS_App/public/api';

  static const imageProgramBaseUrl = 'https://admin.asas-app.com/assets/image/programs/';
  static const imageCompanyBaseUrl = 'https://admin.asas-app.com/assets/image/company/';
  static const imageCompanyTypeBaseUrl = 'https://admin.asas-app.com/assets/image/company_type/';
  static const imageStudentBaseUrl = 'https://admin.asas-app.com/assets/image/children/';

  /// User Auth
  static const userLoginUrl = '/fathers/login';
  static const userLoginWithFacebookUrl = '/social/login/father';
  static const userSignup = '/fathers/register';
  static const getProfile = '/father';
  static const updateProfile = '/father/update';

  /// Owner Auth
  static const ownerSignup = '/facility_owners';
  static const loginUrl = '/facility_owners/login';

  /// Codes
  static const getTimeTypes = '/time_types/all';
  static const getProgramTypes = '/program_types/all';
  static const getCurriculum = '/curriculum/all';

  /// Programmes
  static const getPrograms = '/programs/all/id_facility_owner/{user_id}';
  static const addProgram = '/programs/save';
  static const deleteProgram = '/programs_destroy/id/{id}';
  static const getProgramById = '/programs/id/{id}';
  static const getProgramComById = '/programs-withFacility/id/{id}';
  static const updateProgram = '/programs/update/id/{id}';
  static const copyProgram = '/programs/copy/id/{id}';

  /// Discount
  static const addDiscount = '/program/discountSave';
  static const deleteDiscount = '/program/discountDestroy/id/{id}';

  /// Service
  static const addService = '/service_more/save';
  static const deleteService = '/service_more/destory/id/{id}';

  /// Media
  static const addMedia = '/media/save';
  static const deleteMedia = '/media_destroy/id/{id}';

  /// Company
  static const getAllCompany = '/companydata_all/id_city/{id_city}/type_sort/rate';
  static const getTopRatedCompany = '/companydata_all/id_city/{id_city}/type_sort/rate';
  static const getCompanyByLocation = '/companydata_all/sort/location/home/id_city/{city_id}';
  static const getMyCompany = '/my_companydata_singl';
  static const updateCompany = '/companydata_update/id/{id}';
  static const getCompanyTypes = '/company_types/all';
  static const getCompanyByIdWithFav = '/companydata/id/{id}/{id_father}';
  static const getCompanyById = '/companydata/id/{id}';
  static const getReservation = '/company/children/reservation/my';
  static const getReservationDetails = '/company/children/reservation/my/single/{id}';
  static const getReservationByStatusId = '/company/children/reservation/my/singleStatus/{id}';


  /// USER -> Students
  static const getStudents = '/fathers/children/myChildren';
  static const deleteStudents = '/fathers/children/destroy/id/{id}';
  static const addStudents = '/fathers/children/create';
  static const updateStudents = '/fathers/children/update/id/{id}';
  static const getStudentById = '/children/single/id/{id}';
  static const addStudentToProgram = '/fathers/children/reservation/create';


  /// Settings
  static const getCountries = '/setting/country';
  static const getCity = '/setting/city/mycountry/{id}';
  static const getDistrict = '/setting/area/mycity/{id}';
  static const getAgreements = '/agreements/facility_owner';
  static const getCurrency = '/setting/coins';
  static const updateCurrency = '/companydata/update_languege_coin';


  /// Home
  static const getCompaniesByCountryAndCityId = '/companydata/filter/id_country/{id_country}/id_city/{id_city}';
  static const getCompaniesByToken = '/companydata/filter/country_city';
  static const getCompaniesByCategoryId = '/companydata/filter/id_company_type/{id}/id_city/{id_city}';

  /// Chat
  static const getChat = '/chat/my/id_company/{id_company}/id_father/{id_father}';
  static const sendMessage = '/chat/send';
  static const getChatList = '/chat/my/main';

  /// Comment
  static const addComment = '/fathers/opinion';
  static const getComments = '/opinions/id_company/{id}';

  /// Booking
  static const getMyBooking = '/fathers/children/reservation/my';
  static const deleteBooking = '/fathers/children/reservation/my/delete/id/{id}';
  static const getStudentsNotReserved = '/fahters/children/not_register/id_program/{id}';
  static const getReservationStatus = '/reservation_status/all';
  static const updateReservationStatus = '/update/children_program/reservation_status';

  /// Rating
  static const addRate = '/companydata_rate';
  static const getRate = '/companydata_rate/id_company/{id}';

  /// Search
  static const companySearch = '/companydata/likeSearch/{query}/{city_id}';
  static const companyCategorySearch = '/companydata/likeSearch/{query}/{city_id}/{id}';
  static const companyProgramsSearch = '/programs/id_type_program/{id}';
  static const programsSearch = '/programs/id_type_program/{id}/id_city/{id_city}/{query}';


  /// Notification
  static const getNotification = '/getnotification_father_read_and_noteRead';
  static const getNotificationCount = '/count-notification_father_not_read';

  static const getComNotification = '/getnotification_facility_read_and_noteRead';
  static const getComNotificationCount = '/count-notification_facility_not_read';


  /// Favorite
  static const getFavorite = '/favorate/get';
  static const addFavorite = '/favorate/save/{id_company}';
  static const deleteFavorite = '/favorate/delete/{favorite_id}';
  static const getCoinsType = '/coins/id_user/{user_id}/type/{type}';

  static const getCountNotRead = '/countNotRead/id_company/{id_company}/id_father/{id_father}';






}