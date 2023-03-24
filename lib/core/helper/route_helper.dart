import 'dart:convert';
import 'package:demandium/data/model/notification_body.dart';
import 'package:get/get.dart';
import 'package:demandium/core/initial_binding/initial_binding.dart';
import 'package:demandium/feature/category/bindings/category_bindings.dart';
import 'package:demandium/feature/category/view/sub_category_screen.dart';
import 'package:demandium/feature/checkout/view/payment_screen.dart';
import 'package:demandium/feature/service/view/all_service_view.dart';
import 'package:demandium/feature/html/html_viewer_screen.dart';
import 'package:demandium/feature/settings/bindings/settings_bindings.dart';
import 'package:demandium/utils/html_type.dart';
import 'package:demandium/core/core_export.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String language = '/language';
  static const String offers = '/offers';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String verification = '/verification';
  static const String accessLocation = '/access-location';
  static const String pickMap = '/pick-map';
  static const String main = '/main';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String searchScreen = '/search';
  static const String service = '/service';
  static const String profile = '/profile';
  static const String profileEdit = '/profile-edit';
  static const String notification = '/notification';
  static const String map = '/map';
  static const String address = '/address';
  static const String orderSuccess = '/order-completed';
  static const String checkout = '/checkout';
  static const String orderTracking = '/track-order';
  static const String html = '/html';
  static const String categories = '/categories';
  static const String categoryProduct = '/category-product';
  static const String popularFoods = '/popular-foods';
  static const String itemCampaign = '/item-campaign';
  static const String support = '/help-and-support';
  static const String rateReview = '/rate-and-review';
  static const String update = '/update';
  static const String cart = '/cart';
  static const String addAddress = '/add-address';
  static const String editAddress = '/edit-address';
  static const String restaurantReview = '/restaurant-review';
  static const String serviceImages = '/service-images';
  static const String chatScreen = '/chat-screen';
  static const String chatInbox = '/chat-inbox';
  static const String onBoardScreen = '/onBoardScreen';
  static const String settingScreen = '/settingScreen';
  static const String languageScreen = '/language-screen';
  static const String voucherScreen = '/voucherScreen';
  static const String bookingDetailsScreen = '/bookingDetailsScreen';
  static const String rateReviewScreen = '/rateReviewScreen';
  static const String allServiceScreen = '/allServiceScreen';
  static const String subCategoryScreen = '/subCategoryScreen';
  static const String paymentPage = '/paymentPage';
  static const String invoice = '/invoice';
  static const String completeBooking = '/completeBooking';
  static const String bookingScreen = '/bookingScreen';
  static const String notLoggedScreen = '/notLoggedScreen';


  static String getInitialRoute() => '$initial';
  static String getSplashRoute(NotificationBody? body) {
    String _data = 'null';
    if(body != null) {
      List<int> _encoded = utf8.encode(jsonEncode(body));
      _data = base64Encode(_encoded);
    }
    return '$splash?data=$_data';
  }
  static String getLanguageRoute(String page) => '$language?page=$page';
  static String getOffersRoute(String page) => '$offers?page=$page';
  static String getSignInRoute(String page) => '$signIn?page=$page';
  static String getSignUpRoute() => '$signUp';
  static String getVerificationRoute(String number) {
    String data = base64Url.encode(utf8.encode(jsonEncode(number)));
    return '$verification?number=$data';
  }
  static String getAccessLocationRoute(String page) =>
      '$accessLocation?page=$page';
  static String getPickMapRoute(String page, bool canRoute, String isFromCheckout) {
   return '$pickMap?page=$page&route=${canRoute.toString()}&checkout=$isFromCheckout';
  }
  static String getMainRoute(String page) => '$main?page=$page';
  static String getResetPasswordRoute(String phoneOrEmail, String otp) {
    String data = base64Url.encode(utf8.encode(jsonEncode(phoneOrEmail)));
    return '$resetPassword?phoneOrEmail=$data&otp=$otp';
  }
  static String getSearchResultRoute({String? queryText}) => '$searchScreen?query=${queryText ?? ''}';
  static String getServiceRoute(String id) => '$service?id=$id';
  static String getProfileRoute() => '$profile';
  static String getEditProfileRoute() => '$profileEdit';
  static String getNotificationRoute() => '$notification';
  static String getMapRoute(AddressModel addressModel, String page) {
    List<int> _encoded = utf8.encode(jsonEncode(addressModel.toJson()));
    String _data = base64Encode(_encoded);
    return '$map?address=$_data&page=$page';
  }

  static String getAddressRoute(String fromPage) => '$address?fromProfileScreen=$fromPage';
  static String getOrderSuccessRoute( String status) => '$orderSuccess?payment_status=$status';
  static String getCheckoutRoute(String page,String currentPage,String addressId) {
    return '$checkout?currentPage=$currentPage&addressID=$addressId';
  }
  static String getOrderTrackingRoute(int id) => '$orderTracking?id=$id';
  static String getHtmlRoute(String page) => '$html?page=$page';
  static String getCategoryRoute(String fromPage,String campaignID) => '$categories?fromPage=$fromPage&campaignID=$campaignID';
  static String getCategoryProductRoute(String id, String name, String subCategoryIndex) {
    List<int> _encoded = utf8.encode(name);
    String _data = base64Encode(_encoded);
    return '$categoryProduct?id=$id&name=$_data&subCategoryIndex=$subCategoryIndex';
  }

  static String getPopularFoodRoute() => '$popularFoods?page=popular';
  static String getItemCampaignRoute() => '$itemCampaign';
  static String getSupportRoute() => '$support';
  static String getReviewRoute() => '$rateReview';
  static String getUpdateRoute(bool isUpdate) => '$update?update=${isUpdate.toString()}';
  static String getCartRoute() => '$cart';
  static String getAddAddressRoute(bool fromCheckout) => '$addAddress?page=${fromCheckout ? 'checkout' : 'address'}';
  static String getEditAddressRoute(AddressModel address) {
    String _data = base64Url.encode(utf8.encode(jsonEncode(address.toJson())));
    return '$editAddress?data=$_data';
  }
  static String getRestaurantReviewRoute(int restaurantID) =>
      '$restaurantReview?id=$restaurantID';


  static String getItemImagesRoute(Service product) {
    String _data = base64Url.encode(utf8.encode(jsonEncode(product.toJson())));
    return '$serviceImages?item=$_data';
  }

  static String getChatScreenRoute(
      String channelId,
      String name,
      String image,
      String phone,
      String bookingID){
    return '$chatScreen?channelID=$channelId&name=$name&image=$image&phone=$phone&bookingID=$bookingID';
  }


  static String getSettingRoute() => '$settingScreen';
  static String getBookingScreenRoute(bool isFromMenu) => '$bookingScreen?isFromMenu=$isFromMenu';

  static String getInboxScreenRoute() => '$chatInbox';
  static String getVoucherRoute() => '$voucherScreen';

  static String getBookingDetailsScreen(String bookingID, String fromPage) {
    return '$bookingDetailsScreen?bookingID=$bookingID&fromPage=$fromPage';
  }

  static String getRateReviewScreen(
      String id,
      ) {
    // List<int> _encoded = utf8.encode(jsonEncode(bookingDetailsContent.toJson()));
    // String _data = base64Encode(_encoded);
    return '$rateReviewScreen?id=$id';
  }
  static String getForgotPassRoute() => '$forgotPassword';
  static String allServiceScreenRoute(String fromPage, {String campaignID = ''}) => '$allServiceScreen?fromPage=$fromPage&campaignID=$campaignID';
  static String subCategoryScreenRoute(String categoryName,String categoryID,int subCategoryIndex) {
    return '$subCategoryScreen?categoryName=$categoryName&categoryId=$categoryID&subCategoryIndex=$subCategoryIndex';
  }
  static String getPaymentScreen(String url) => '$paymentPage?url=$url';
  static String getInvoiceRoute(String bookingID) => '$invoice?bookingID=$bookingID';
  static String getCompletedBooking() => '$completeBooking';
  static String getLanguageScreen(String fromPage) => '$languageScreen?fromPage=$fromPage';
  static String getNotLoggedScreen(String fromPage) => '$notLoggedScreen?fromPage=$fromPage';


  static List<GetPage> routes = [
    GetPage(name: initial, binding: BottomNavBinding(), page: () => getRoute(BottomNavScreen(pageIndex: 0))),
    GetPage(name: splash, page: () {
      NotificationBody? _data;
      if(Get.parameters['data'] != 'null') {
        List<int> _decode = base64Decode(Get.parameters['data']!.replaceAll(' ', '+'));
        _data = NotificationBody.fromJson(jsonDecode(utf8.decode(_decode)));
      }
      return SplashScreen(body: _data != null ? _data:null);
    }),
    GetPage(name: language, page: () => ChooseLanguageBottomSheet()),
    GetPage(name: languageScreen, page: () => LanguageScreen(fromPage: Get.parameters['fromPage']!,)),
    GetPage(name: offers, page: () => getRoute(OfferScreen())),
    GetPage(name: signIn, page: () => SignInScreen(exitFromApp: Get.parameters['page'] == signUp || Get.parameters['page'] == splash,)),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: verification, page: () {
      List<int> _decode = base64Decode(Get.parameters['number']!.replaceAll(' ', '+'));
      String _data = utf8.decode(_decode);
      return VerificationScreen(
        number: _data,
      );
    }),
    GetPage(name: accessLocation, page: () => AccessLocationScreen(
      fromSignUp: Get.parameters['page'] == signUp,
      fromHome: Get.parameters['page'] == 'home', route: null,
    )),
    GetPage(
        name: pickMap,
        page: () {
          PickMapScreen? _pickMapScreen = Get.arguments;
          bool _fromAddress = Get.parameters['page'] == 'add-address';
          return (_fromAddress && _pickMapScreen == null) ? NotFoundScreen() :
          _pickMapScreen != null ? _pickMapScreen :
          PickMapScreen(
              fromSignUp: Get.parameters['page'] == signUp,
              fromAddAddress: _fromAddress, route: Get.parameters['page']!,
              canRoute: Get.parameters['route'] == 'true',
              formCheckout: Get.parameters['checkout'] == 'true'
      );
    }),
    GetPage(
        binding: BottomNavBinding(),
        name: main,
        page: () => getRoute(BottomNavScreen(
          pageIndex: Get.parameters['page'] == 'home' ? 0 :
          Get.parameters['page'] == 'favourite' ? 1 :
          Get.parameters['page'] == 'cart' ? 2 :
          Get.parameters['page'] == 'order' ? 3 :
          Get.parameters['page'] == 'menu' ? 4 : 0,
    ))),

    GetPage(name: forgotPassword, page: ()=> ForgetPassScreen()),
    GetPage(name: resetPassword, page: () {
      List<int> _decode = base64Decode(Get.parameters['phoneOrEmail']!.replaceAll(' ', '+'));
      String _data = utf8.decode(_decode);
      return NewPassScreen(
        phoneOrEmail: _data,
        otp: Get.parameters['otp']!,
      );
    }),

    GetPage(
        name: searchScreen,
        page: () => getRoute(SearchResultScreen(queryText: Get.parameters['query']))),
    GetPage(
        name: service,
        binding: ServiceDetailsBinding(),
        page: () {
          return getRoute(Get.arguments != null ? Get.arguments : ServiceDetailsScreen(serviceID: Get.parameters['id']!));}),

    GetPage(name: profile, page: () => getRoute(ProfileScreen())),
    GetPage(
        binding: EditProfileBinding(),
        name: profileEdit, page: () => getRoute(EditProfileScreen())),
    GetPage(name: notification, page: () => getRoute(NotificationScreen())),
    GetPage(
        name: map,
        page: () {
          List<int> _decode = base64Decode(Get.parameters['address']!.replaceAll(' ', '+'));
          AddressModel _data = AddressModel.fromJson(jsonDecode(utf8.decode(_decode)));
          return getRoute(MapScreen( address: _data));
      }),
      GetPage(
          name: orderSuccess,
          page: () => getRoute(OrderSuccessfulScreen(status: Get.parameters['payment_status']!.contains('success') ? 1 : 0,))
      ),
      GetPage(
          binding: CheckoutBinding(),
          name: checkout, page: () {

            if(Get.parameters['payment_status'] == 'cancelled')
            return getRoute(OrderSuccessfulScreen(status: 0,));
            if(Get.parameters['payment_status'] == 'canceled')
            return getRoute(OrderSuccessfulScreen(status: 0,));
            if(Get.parameters['payment_status'] == 'failed')
            return getRoute(OrderSuccessfulScreen(status: 0,));

            return getRoute(CheckoutScreen(
                Get.parameters.containsKey('payment_status') && Get.parameters['payment_status']! == 'success' ? 'complete'
                    : Get.parameters['currentPage']!,   Get.parameters['addressID'] != null ? Get.parameters['addressID']! :'null' ));
      }),
      GetPage(
          binding: InitialBinding(),
          name: html,
          page: () => HtmlViewerScreen(
              htmlType:
              Get.parameters['page'] == 'terms-and-condition' ? HtmlType.TERMS_AND_CONDITION :
              Get.parameters['page'] == 'privacy-policy' ? HtmlType.PRIVACY_POLICY :
              Get.parameters['page'] == 'cancellation_policy' ? HtmlType.CANCELLATION_POLICY :
              Get.parameters['page'] == 'refund_policy' ? HtmlType.REFUND_POLICY :
              HtmlType.ABOUT_US
      )),

      GetPage(
          name: categories,
          page: () => getRoute(CategoryScreen(fromPage: Get.parameters['fromPage']!,campaignID:Get.parameters['campaignID']!))),
      GetPage(
          binding: CategoryBindings(),
          name: categoryProduct,
          page: () {
            List<int> _decode = base64Decode(Get.parameters['name']!.replaceAll(' ', '+'));
            String _data = utf8.decode(_decode);
            return getRoute(CategorySubCategoryScreen(
              categoryID: Get.parameters['id']!,
              categoryName: _data,
              subCategoryIndex: Get.parameters['subCategoryIndex']!,
            ));
      }),
      GetPage(name: support, page: () => ContactUsPage()),
      GetPage(name: update, page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),
      GetPage(name: cart, page: () => getRoute(CartScreen(fromNav: false))),
      GetPage(name: addAddress, page: () => getRoute(AddAddressScreen(fromCheckout: Get.parameters['page'] == 'checkout'))),
      GetPage(
          name: editAddress,
          page: () => getRoute(AddAddressScreen(
            fromCheckout: false,
            address: AddressModel.fromJson(jsonDecode(utf8.decode(base64Url.decode(Get.parameters['data']!.replaceAll(' ', '+'))))),
      ))),
      GetPage(
          name: rateReview,
          page: () => getRoute(Get.arguments != null ?
          Get.arguments : NotFoundScreen())),
    GetPage(name: chatScreen, page: () => getRoute(
        ConversationScreen(
          channelID: Get.parameters['channelID']!,
          image: Get.parameters['image']!,
          name: Get.parameters['name']!,
          phone: Get.parameters['phone']!,
          bookingID: Get.parameters['bookingID']!
        )),
        binding: ConversationBinding()),

      GetPage(name: chatInbox,binding: ConversationBinding(), page: () => ChannelList()),
      GetPage(name: address, page: ()=>AddressScreen(fromPage:Get.parameters['fromProfileScreen']!),),
      GetPage(binding: OnBoardBinding(),name: onBoardScreen, page: ()=>OnBoardingScreen(),),
      GetPage(name: settingScreen,binding: SettingsBinding(), page: ()=>SettingScreen(),),
      GetPage(name: voucherScreen, page: ()=> CouponScreen(),),
      GetPage(binding: BookingBinding(),name: bookingDetailsScreen, page: ()=> BookingDetailsScreen(
        bookingID: Get.parameters['bookingID']!,
        fromPage: Get.parameters['fromPage']!,
      ),),
      GetPage(binding: ServiceBinding(),name: allServiceScreen, page:  ()=> getRoute(AllServiceView(fromPage: Get.parameters['fromPage']!,campaignID: Get.parameters['campaignID']!,)),),
      GetPage(binding: ServiceBinding(),name: subCategoryScreen, page: ()=> SubCategoryScreen(
        categoryTitle: Get.parameters['categoryName']!,
        categoryID: Get.parameters['categoryId']!,
        subCategoryIndex: int.parse(Get.parameters['subCategoryIndex']!),
      ),),
      GetPage(
        binding: SubmitReviewBinding(),
        name: rateReviewScreen, page: () {
        // List<int> _decode = base64Decode(Get.parameters['bookingDetailsContent']!.replaceAll(' ', '+'));
        // BookingDetailsContent _data = BookingDetailsContent.fromJson(jsonDecode(utf8.decode(_decode)));
          return RateReviewScreen(
            id : Get.parameters['id'].toString(),
          );
          },),
    GetPage(binding: CheckoutBinding(),name: paymentPage, page: ()=> PaymentScreen(url: Get.parameters['url']!,)),
    GetPage(name: bookingScreen, page: ()=> BookingScreen( isFromMenu: Get.parameters['isFromMenu'] == "true"? true: false)),
    GetPage(name: notLoggedScreen, page: ()=> NotLoggedInScreen( fromPage: Get.parameters['fromPage']!)),
    ];

  static getRoute(Widget navigateTo) {
    double _minimumVersion = 1;
    if(Get.find<SplashController>().configModel.content!.minimumVersion!=null){
      if(GetPlatform.isAndroid) {
        _minimumVersion = double.parse(Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForAndroid!.toString());
      }else if(GetPlatform.isIOS) {
        _minimumVersion = double.parse(Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForIos!.toString());
      }
    }
    return 5 < _minimumVersion ? UpdateScreen(isUpdate: true)
        : Get.find<LocationController>().getUserAddress() != null ? navigateTo
        : AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute);
  }
  }
