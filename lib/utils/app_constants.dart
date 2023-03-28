import 'package:demandium/data/model/choose_us_model.dart';
import 'package:demandium/data/model/response/language_model.dart';
import 'package:demandium/utils/images.dart';

class AppConstants {
  static const String APP_NAME = 'Demandium';
  static const String APP_VERSION = '1.3';
  static const String BASE_URL = 'https://demandium-admin.6amtech.com';
  static const String CATEGORY_URI = '/api/v1/customer/category?limit=20';
  static const String WEB_LANDING_CONTENTS = '/api/v1/customer/landing/contents';
  static const String BANNER_URI = '/api/v1/customer/banner?limit=10&offset=1';
  static const String ALL_SERVICE_URI = '/api/v1/customer/service';
  static const String POPULAR_SERVICE_URI = '/api/v1/customer/service/popular';
  static const String TRENDING_SERVICE_URI = '/api/v1/customer/service/trending';
  static const String RECENTLY_VIEWED_SERVICE_URI = '/api/v1/customer/service/recently-viewed';
  static const String RECOMMENDED_SERVICE_URI = '/api/v1/customer/service/recommended';
  static const String RECOMMENDED_SEARCH_URI = '/api/v1/customer/service/search/recommended';
  static const String OFFER_LIST_URI = '/api/v1/customer/service/offers';
  static const String SERVICE_BASED_ON_SUB_CATEGORY = '/api/v1/customer/service/sub-category/';
  static const String ITEMS_BASED_ON_CAMPAIGN_ID = '/api/v1/customer/campaign/data/items?campaign_id=';
  static const String SERVICE_DETAILS_URI = '/api/v1/customer/service/detail';
  static const String GET_SERVICE_REVIEW_LIST = '/api/v1/customer/service/review/';
  static const String SUB_CATEGORY_URI = '/api/v1/customer/category/childes?limit=20&offset=1&id=';
  static const String CATEGORY_SERVICE_URI = '/api/v1/categories/service/';
  static const String CONFIG_URI = '/api/v1/customer/config';
  static const String CUSTOMER_REMOVE = '/api/v1/customer/remove-account';
  static const String TRACK_URI = '/api/v1/customer/order/track?order_id=';
  static const String MESSAGE_URI = '/api/v1/customer/message/get';
  static const String SEND_MESSAGE_URI = '/api/v1/customer/message/send';
  static const String FORGET_PASSWORD_URI = '/api/v1/customer/forgot-password';
  static const String VERIFY_TOKEN_URI = '/api/v1/customer/otp-verification';
  static const String RESET_PASSWORD_URI = '/api/v1/customer/reset-password';
  static const String VERIFY_PHONE_URI = '/api/v1/auth/verify-phone';
  static const String CHECK_EMAIL_URI = '/api/v1/auth/check-email';
  static const String VERIFY_EMAIL_URI = '/api/v1/auth/verify-email';
  static const String REGISTER_URI = '/api/v1/customer/auth/registration';
  static const String LOGIN_URI = '/api/v1/customer/auth/login';
  static const String ADD_TO_CART = '/api/v1/customer/cart/add';
  static const String GET_CART_LIST = '/api/v1/customer/cart/list?limit=100&offset=1';
  static const String REMOVE_CART_ITEM = '/api/v1/customer/cart/remove/';
  static const String REMOVE_ALL_CART_ITEM = '/api/v1/customer/cart/data/empty';
  static const String UPDATE_CART_QUANTITY = '/api/v1/customer/cart/update-quantity/';
  static const String UPDATE_CART_PROVIDER = '/api/v1/customer/cart/update/provider';
  static const String TOKEN_URI = '/api/v1/customer/update/fcm-token';
  static const String BOOKING_LIST = '/api/v1/customer/booking';
  static const String BOOKING_DETAILS = '/api/v1/customer/booking';
  static const String BOOKING_CANCEL = '/api/v1/customer/booking/status-update';
  static const String SERVICE_REVIEW = '/api/v1/customer/review/submit';
  static const String BOOKING_REVIEW_LIST = '/api/v1/customer/review';
  static const String OTHERS_INFO = '/api/v1/customer/cart/other-info';
  static const String PLACE_REQUEST = '/api/v1/customer/booking/request/send';
  static const String ADDRESS_URI = '/api/v1/customer/address';
  static const String ZONE_URI = '/api/v1/customer/config/get-zone-id';
  static const String SET_MENU_URI = '/api/v1/products/set-menu';
  static const String CUSTOMER_INFO_URI = '/api/v1/customer/info';
  static const String COUPON_URI = '/api/v1/customer/coupon?limit=100&offset=1';
  static const String APPLY_COUPON = '/api/v1/customer/coupon/apply';
  static const String REMOVE_COUPON = '/api/v1/customer/coupon/remove';
  static const String ORDER_CANCEL_URI = '/api/v1/customer/order/cancel';
  static const String COD_SWITCH_URL = '/api/v1/customer/order/payment-method';
  static const String ORDER_DETAILS_URI = '/api/v1/customer/order/details?order_id=';
  static const String WISH_LIST_GET_URI = '/api/v1/customer/wish-list';
  static const String ADD_WISH_LIST_URI = '/api/v1/customer/wish-list/add?';
  static const String REMOVE_WISH_LIST_URI = '/api/v1/customer/wish-list/remove?';
  static const String NOTIFICATION_URI = '/api/v1/customer/notification';
  static const String UPDATE_PROFILE_URI = '/api/v1/customer/update/profile';
  static const String SEARCH_URI = '/api/v1/customer/service/search';
  static const String SUGGESTED_SEARCH_URI = '/api/v1/customer/recently-searched-keywords';
  static const String REMOVE_SUGGESTED_SEARCH_URI = '/api/v1/customer/remove-searched-keywords';
  static const String CAMPAIGN_URI = '/api/v1/customer/campaign?limit=10&offset=1';
  static const String DISTANCE_MATRIX_URI = '/api/v1/customer/config/distance-api';
  static const String SEARCH_LOCATION_URI = '/api/v1/customer/config/place-api-autocomplete';
  static const String PLACE_DETAILS_URI = '/api/v1/customer/config/place-api-details';
  static const String GEOCODE_URI = '/api/v1/customer/config/geocode-api';
  static const String SOCIAL_LOGIN_URL = '/api/v1/customer/auth/social-login';
  static const String SOCIAL_REGISTER_URL = '/api/v1/auth/social-register';
  static const String UPDATE_ZONE_URL = '/api/v1/customer/update-zone';
  static const String CREATE_CHANNEL = '/api/v1/customer/chat/create-channel';
  static const String GET_CHANNEL_LIST = '/api/v1/customer/chat/channel-list?limit=10&';
  static const String GET_CONVERSATION = '/api/v1/customer/chat/conversation';
  static const String SEND_MESSAGE = '/api/v1/customer/chat/send-message';
  static const String PAGES = '/api/v1/customer/config/pages';
  static const String SUBSCRIPTION_URI = '/api/v1/newsletter/subscribe';
  static const String SUBMIT_NEW_SERVICE_REQUEST = '/api/v1/customer/service/request/make';
  static const String GET_SUGGESTED_SERVICE_LIST = '/api/v1/customer/service/request/list';
  static const String CONVERT_LOYALTY_POINT_TO_WALLET = '/api/v1/customer/loyalty-point/wallet-transfer';
  static const String LOYALTY_POINT_TRANSACTION_DATA = '/api/v1/customer/loyalty-point-transaction';
  static const String WALLET_TRANSACTION_DATA = '/api/v1/customer/wallet-transaction';
  static const String GET_PROVIDER_LIST = '/api/v1/customer/provider/list?limit=10&offset=';
  static const String GET_PROVIDER_DETAILS = '/api/v1/customer/provider/details';
  static const String GET_PROVIDER_BASED_ON_SUBCATEGORY = '/api/v1/customer/provider/list-by-sub-category';
  static const String GET_FEATHERED_SERVICE_CATEGORY = '/api/v1/customer/featured-categories?limit=100&offset=1';

  static List<ChooseUsModel> whyChooseUsList = [
    ChooseUsModel(icon: Images.landingTrusted, title: 'trusted_by_customers_and_store_owners'),
    ChooseUsModel(icon: Images.landingStores, title: 'thousands_of_stores'),
    ChooseUsModel(icon: Images.landingExcellent, title: 'excellent_shopping_experience'),
    ChooseUsModel(icon: Images.landingCheckout, title: 'easy_checkout_and_payment_system'),
  ];

  // Shared Key
  static const String THEME = 'demand_theme';
  static const String TOKEN = 'demand_token';
  static const String COUNTRY_CODE = 'demand_country_code';
  static const String LANGUAGE_CODE = 'demand_language_code';
  static const String CART_LIST = 'demand_cart_list';
  static const String ACCEPT_COOKIES = 'demand_accept_cookies';
  static const String USER_PASSWORD = 'demand_user_password';
  static const String USER_ADDRESS = 'demand_user_address';
  static const String USER_NUMBER = 'demand_user_number';
  static const String USER_COUNTRY_CODE = 'demand_user_country_code';
  static const String NOTIFICATION = 'demand_notification';
  static const String SEARCH_HISTORY = 'demand_search_history';
  static const String NOTIFICATION_COUNT = 'demand_notification_count';
  static const String IS_SPLASH_SEEN = 'demand_splash_seen';
  static const String  TOPIC = 'customer';
  static const String ZONE_ID = 'zoneId';
  static const String LOCALIZATION_KEY = 'X-localization';
  static const int SCHEDULE_TIME = 3;

  static Map<String, String> configHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
    AppConstants.ZONE_ID: 'configuration',
  };


  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.us, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.arabicTwo, languageName: 'عربى', countryCode: 'SA', languageCode: 'ar'),
  ];
  static const double limitOfPickedImageSizeInMB = 2;

}
