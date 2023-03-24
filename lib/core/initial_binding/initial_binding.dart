import 'package:demandium/feature/conversation/repo/conversation_repo.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/repository/web_landing_repo.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/html/controller/webview_controller.dart';
import 'package:demandium/feature/html/repository/html_repo.dart';
import 'package:demandium/feature/notification/repository/notification_repo.dart';
import 'package:demandium/feature/service_booking/repo/booking_details_repo.dart';
import 'package:demandium/feature/voucher/controller/coupon_controller.dart';
export 'package:demandium/feature/cart/repository/cart_repo.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async {
    //common controller
    Get.lazyPut(() => SplashController(splashRepo: SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => AuthController(authRepo: AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
    Get.lazyPut(() => WebLandingController( WebLandingRepo( apiClient: Get.find())));
    Get.lazyPut(() => NotificationController( notificationRepo: NotificationRepo(apiClient:Get.find() , sharedPreferences: Get.find())));
    Get.lazyPut(() => LanguageController());
    Get.lazyPut(() => CategoryController(categoryRepo: CategoryRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServiceBookingController(serviceBookingRepo: ServiceBookingRepo(sharedPreferences:Get.find(),apiClient: Get.find())));
    Get.lazyPut(() => UserController(userRepo: UserRepo(apiClient: Get.find())));
    Get.lazyPut(() => CouponController(couponRepo: CouponRepo(apiClient: Get.find())));
    Get.lazyPut(() => ScheduleController());
    Get.lazyPut(() => BookingDetailsTabsController(bookingDetailsRepo: BookingDetailsRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => SearchController(searchRepo: SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => ServiceController(serviceRepo: ServiceRepo(apiClient: Get.find())));
    Get.lazyPut(() => HtmlViewController(htmlRepository: HtmlRepository(apiClient: Get.find())));
    Get.lazyPut(() => ConversationController(conversationRepo: ConversationRepo(apiClient: Get.find())));
    Get.lazyPut(() => CheckOutController());
  }
}