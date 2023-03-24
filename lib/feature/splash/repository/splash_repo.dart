import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class SplashRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SplashRepo({ required this.apiClient, required this.sharedPreferences});

  Future<Response> getConfigData() async {
    Response _response = await apiClient.getData(AppConstants.CONFIG_URI,headers: AppConstants.configHeader);
    return _response;
  }

  Future<bool> initSharedData() async {

    if(!sharedPreferences.containsKey(AppConstants.THEME)) {
      sharedPreferences.setBool(AppConstants.THEME, false);
    }
    if(!sharedPreferences.containsKey(AppConstants.COUNTRY_CODE)) {
      sharedPreferences.setString(AppConstants.COUNTRY_CODE, AppConstants.languages[0].countryCode!);
    }
    if(!sharedPreferences.containsKey(AppConstants.LANGUAGE_CODE)) {
      sharedPreferences.setString(AppConstants.LANGUAGE_CODE, AppConstants.languages[0].languageCode!);
    }
    if(!sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    }
    if(!sharedPreferences.containsKey(AppConstants.SEARCH_HISTORY)) {
      sharedPreferences.setStringList(AppConstants.SEARCH_HISTORY, []);
    }
    if(!sharedPreferences.containsKey(AppConstants.NOTIFICATION)) {
      sharedPreferences.setBool(AppConstants.NOTIFICATION, true);
    }
    if(!sharedPreferences.containsKey(AppConstants.NOTIFICATION_COUNT)) {
      sharedPreferences.setInt(AppConstants.NOTIFICATION_COUNT, 0);
    }


    return Future.value(true);
  }

  String getZoneId() => sharedPreferences.getString(AppConstants.ZONE_ID)!;

  Future<bool> setSplashSeen(bool isSplashSeen) async {
    return await sharedPreferences.setBool(AppConstants.IS_SPLASH_SEEN, isSplashSeen);
  }

  bool isSplashSeen() {
    return sharedPreferences.getBool(AppConstants.IS_SPLASH_SEEN) != null ? sharedPreferences.getBool(AppConstants.IS_SPLASH_SEEN)! : false;
  }

  Future<Response> subscribeEmail(String email) async {
    return await apiClient.postData(AppConstants.SUBSCRIPTION_URI, {'email': email});
  }

}
