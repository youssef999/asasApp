import 'package:get/get.dart';

import '../modules/owner/add_location/bindings/owner_add_location_binding.dart';
import '../modules/owner/add_location/views/owner_add_location_view.dart';
import '../modules/owner/add_program/bindings/owner_add_program_binding.dart';
import '../modules/owner/add_program/views/owner_add_program_view.dart';
import '../modules/owner/agreement/bindings/owner_agreement_binding.dart';
import '../modules/owner/agreement/views/owner_agreement_view.dart';
import '../modules/owner/booking_details/bindings/owner_booking_details_binding.dart';
import '../modules/owner/booking_details/views/owner_booking_details_view.dart';
import '../modules/owner/booking_requsets/bindings/owner_booking_requsets_binding.dart';
import '../modules/owner/booking_requsets/views/owner_booking_requsets_view.dart';
import '../modules/owner/drawer/bindings/owner_drawer_binding.dart';
import '../modules/owner/drawer/views/owner_drawer_view.dart';
import '../modules/owner/edit_program/bindings/owner_edit_program_binding.dart';
import '../modules/owner/edit_program/views/owner_edit_program_view.dart';
import '../modules/owner/home/bindings/owner_home_binding.dart';
import '../modules/owner/home/views/owner_home_view.dart';
import '../modules/owner/login/bindings/owner_login_binding.dart';
import '../modules/owner/login/views/owner_login_view.dart';
import '../modules/owner/notification/bindings/owner_notification_binding.dart';
import '../modules/owner/notification/views/owner_notification_view.dart';
import '../modules/owner/org_data/bindings/owner_org_data_binding.dart';
import '../modules/owner/org_data/views/owner_org_data_view.dart';
import '../modules/owner/otp/bindings/owner_otp_binding.dart';
import '../modules/owner/otp/views/owner_otp_view.dart';
import '../modules/owner/programs/bindings/owner_programs_binding.dart';
import '../modules/owner/programs/views/owner_programs_view.dart';
import '../modules/owner/settings/bindings/owner_settings_binding.dart';
import '../modules/owner/settings/views/owner_settings_view.dart';
import '../modules/owner/signup/bindings/owner_signup_binding.dart';
import '../modules/owner/signup/views/owner_signup_view.dart';
import '../modules/owner/splash/bindings/owner_splash_binding.dart';
import '../modules/owner/splash/views/owner_splash_view.dart';
import '../modules/shared/chat/bindings/shared_chat_binding.dart';
import '../modules/shared/chat/views/shared_chat_view.dart';
import '../modules/shared/map/bindings/shared_map_binding.dart';
import '../modules/shared/map/views/shared_map_view.dart';
import '../modules/shared/messages/bindings/shared_messages_binding.dart';
import '../modules/shared/messages/views/shared_messages_view.dart';
import '../modules/user/add_location/bindings/user_add_location_binding.dart';
import '../modules/user/add_location/views/user_add_location_view.dart';
import '../modules/user/add_student/bindings/user_add_student_binding.dart';
import '../modules/user/add_student/views/user_add_student_view.dart';
import '../modules/user/category/bindings/user_category_binding.dart';
import '../modules/user/category/views/user_category_view.dart';
import '../modules/user/category_details/bindings/user_category_details_binding.dart';
import '../modules/user/category_details/views/user_category_details_view.dart';
import '../modules/user/edit_address/bindings/user_edit_address_binding.dart';
import '../modules/user/edit_address/views/user_edit_address_view.dart';
import '../modules/user/edit_student/bindings/user_edit_student_binding.dart';
import '../modules/user/edit_student/views/user_edit_student_view.dart';
import '../modules/user/favorite/bindings/user_favorite_binding.dart';
import '../modules/user/favorite/views/user_favorite_view.dart';
import '../modules/user/home/bindings/home_binding.dart';
import '../modules/user/home/views/home_view.dart';
import '../modules/user/intro/bindings/user_intro_binding.dart';
import '../modules/user/intro/views/user_intro_view.dart';
import '../modules/user/login/bindings/login_binding.dart';
import '../modules/user/login/views/login_view.dart';
import '../modules/user/my_booking/bindings/user_my_booking_binding.dart';
import '../modules/user/my_booking/views/user_my_booking_view.dart';
import '../modules/user/my_location/bindings/user_my_location_binding.dart';
import '../modules/user/my_location/views/user_my_location_view.dart';
import '../modules/user/notification/bindings/notification_binding.dart';
import '../modules/user/notification/views/notification_view.dart';
import '../modules/user/profile/bindings/user_profile_binding.dart';
import '../modules/user/profile/views/user_profile_view.dart';
import '../modules/user/program_details/bindings/user_program_details_binding.dart';
import '../modules/user/program_details/views/user_program_details_view.dart';
import '../modules/user/search/bindings/search_binding.dart';
import '../modules/user/search/views/search_view.dart';
import '../modules/user/signup/bindings/signup_binding.dart';
import '../modules/user/signup/views/signup_view.dart';
import '../modules/user/splash/bindings/splash_binding.dart';
import '../modules/user/splash/views/splash_view.dart';
import '../modules/user/student/bindings/user_student_binding.dart';
import '../modules/user/student/views/user_student_view.dart';
import '../widgets/base_widget.dart';
import '../widgets/owner_base_widget.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BASE_DRAWER,
      page: () => BaseWidget(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_LOGIN,
      page: () => OwnerLoginView(),
      binding: OwnerLoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_SIGNUP,
      page: () => OwnerSignupView(),
      binding: OwnerSignupBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
      children: [
        GetPage(
          name: _Paths.OWNER_NOTIFICATION,
          page: () => OwnerNotificationView(),
          binding: OwnerNotificationBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_SPLASH,
      page: () => OwnerSplashView(),
      binding: OwnerSplashBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_HOME,
      page: () => OwnerHomeView(),
      binding: OwnerHomeBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_DRAWER,
      page: () => OwnerDrawerView(),
      binding: OwnerDrawerBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_BASE_DRAWER,
      page: () => OwnerBaseWidget(),
    ),
    GetPage(
      name: _Paths.OWNER_BOOKING_REQUSETS,
      page: () => OwnerBookingRequsetsView(),
      binding: OwnerBookingRequsetsBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_SETTINGS,
      page: () => OwnerSettingsView(),
      binding: OwnerSettingsBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_OTP,
      page: () => OwnerOtpView(),
      binding: OwnerOtpBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_PROGRAMS,
      page: () => OwnerProgramsView(),
      binding: OwnerProgramsBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_ADD_PROGRAM,
      page: () => OwnerAddProgramView(),
      binding: OwnerAddProgramBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_BOOKING_DETAILS,
      page: () => OwnerBookingDetailsView(),
      binding: OwnerBookingDetailsBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_ORG_DATA,
      page: () => OwnerOrgDataView(),
      binding: OwnerOrgDataBinding(),
    ),
    GetPage(
      name: _Paths.USER_INTRO,
      page: () => UserIntroView(),
      binding: UserIntroBinding(),
    ),
    GetPage(
      name: _Paths.USER_CATEGORY,
      page: () => UserCategoryView(),
      binding: UserCategoryBinding(),
    ),
    GetPage(
      name: _Paths.USER_CATEGORY_DETAILS,
      page: () => UserCategoryDetailsView(),
      binding: UserCategoryDetailsBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_EDIT_PROGRAM,
      page: () => OwnerEditProgramView(),
      binding: OwnerEditProgramBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_ADD_LOCATION,
      page: () => OwnerAddLocationView(),
      binding: OwnerAddLocationBinding(),
    ),
    GetPage(
      name: _Paths.USER_STUDENT,
      page: () => UserStudentView(),
      binding: UserStudentBinding(),
    ),
    GetPage(
      name: _Paths.USER_ADD_STUDENT,
      page: () => UserAddStudentView(),
      binding: UserAddStudentBinding(),
    ),
    GetPage(
      name: _Paths.USER_EDIT_STUDENT,
      page: () => UserEditStudentView(),
      binding: UserEditStudentBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_AGREEMENT,
      page: () => OwnerAgreementView(),
      binding: OwnerAgreementBinding(),
    ),
    GetPage(
      name: _Paths.SHARED_CHATE,
      page: () => SharedChatView(),
      binding: SharedChatBinding(),
    ),
    GetPage(
      name: _Paths.SHARED_MESSAGES,
      page: () => SharedMessagesView(),
      binding: SharedMessagesBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROGRAM_DETAILS,
      page: () => UserProgramDetailsView(),
      binding: UserProgramDetailsBinding(),
    ),
    GetPage(
      name: _Paths.USER_MY_BOOKING,
      page: () => UserMyBookingView(),
      binding: UserMyBookingBinding(),
    ),
    GetPage(
      name: _Paths.USER_MY_LOCATION,
      page: () => UserMyLocationView(),
      binding: UserMyLocationBinding(),
    ),
    GetPage(
      name: _Paths.USER_ADD_LOCATION,
      page: () => UserAddLocationView(),
      binding: UserAddLocationBinding(),
    ),
    GetPage(
      name: _Paths.SHARED_MAP,
      page: () => SharedMapView(),
      binding: SharedMapBinding(),
    ),
    GetPage(
      name: _Paths.USER_EDIT_ADDRESS,
      page: () => UserEditAddressView(),
      binding: UserEditAddressBinding(),
    ),
    GetPage(
      name: _Paths.USER_FAVORITE,
      page: () => const UserFavoriteView(),
      binding: UserFavoriteBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
  ];
}
