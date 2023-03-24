import 'dart:convert';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTER_URI, signUpBody.toJson());
  }

  Future<Response?> login({required String phone, required String password}) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"email_or_phone": phone, "password": password});
  }

  Future<Response?> loginWithSocialMedia(SocialLogInBody socialLogInBody) async {
    return await apiClient.postData(AppConstants.SOCIAL_LOGIN_URL, socialLogInBody.toJson(),headers: AppConstants.configHeader);
  }

  Future<Response?> registerWithSocialMedia(SocialLogInBody socialLogInBody) async {
    return await apiClient.postData(AppConstants.SOCIAL_REGISTER_URL, socialLogInBody.toJson());
  }

  Future<Response?> updateToken() async {
    String? _deviceToken;
    if (GetPlatform.isIOS) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true, announcement: false, badge: true, carPlay: false,
        criticalAlert: false, provisional: false, sound: true,
      );
      if(settings.authorizationStatus == AuthorizationStatus.authorized) {
        _deviceToken = await _saveDeviceToken();
      }
    }else {
      _deviceToken = await _saveDeviceToken();
    }

    if(!GetPlatform.isWeb){
      if(Get.find<LocationController>().getUserAddress() != null){
        FirebaseMessaging.instance.subscribeToTopic('${AppConstants.TOPIC}');
        FirebaseMessaging.instance.subscribeToTopic('${AppConstants.TOPIC}-${Get.find<LocationController>().getUserAddress()!.zoneId!}');
      }
    }

    print("_deviceToken");
    print(_deviceToken);
    return await apiClient.postData(AppConstants.TOKEN_URI, {"_method": "put", "fcm_token": _deviceToken});
  }

  Future<String?> _saveDeviceToken() async {
    String? _deviceToken = '@';
    try {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    }catch(e) {}
    if (_deviceToken != null) {
      print('--------Device Token---------- '+_deviceToken);
    }
    return _deviceToken;
  }

  Future<Response?> forgetPassword(String? phone) async {
    return await apiClient.postData(AppConstants.FORGET_PASSWORD_URI, {"phone_or_email": phone});
  }

  Future<Response?> verifyToken(String phone, String otp) async {
    return await apiClient.postData(AppConstants.VERIFY_TOKEN_URI, {"phone_or_email": phone.substring(1,phone.length-1), "otp": otp});
  }

  Future<Response?> resetPassword(String phoneOrEmail, String otp, String password, String confirmPassword) async {
    return await apiClient.postData(
      AppConstants.RESET_PASSWORD_URI,
      {"_method": "put", "phone_or_email": phoneOrEmail, "otp": otp, "password": password, "confirm_password": confirmPassword},
    );
  }

  Future<Response?> checkEmail(String email) async {
    return await apiClient.postData(AppConstants.CHECK_EMAIL_URI, {"email": email});
  }

  Future<Response?> verifyEmail(String email, String token) async {
    return await apiClient.postData(AppConstants.VERIFY_EMAIL_URI, {"email": email, "token": token});
  }

  Future<Response?> updateZone() async {
    return await apiClient.getData(AppConstants.UPDATE_ZONE_URL);
  }

  Future<Response?> verifyPhone(String phone, String otp) async {
    return await apiClient.postData(AppConstants.VERIFY_PHONE_URI, {"phone": phone, "otp": otp});
  }

  Future<bool?> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token, sharedPreferences.getString(AppConstants.USER_ADDRESS) != null ?
    AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)!)).zoneId :
    null, sharedPreferences.getString(AppConstants.LANGUAGE_CODE));
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  ///user address and language code should not be deleted
  bool clearSharedData() {
    if(!GetPlatform.isWeb){
      if(Get.find<LocationController>().getUserAddress() != null){
        if(Get.find<LocationController>().getUserAddress()!.zoneId != null){
          FirebaseMessaging.instance.unsubscribeFromTopic('${AppConstants.TOPIC}');
          FirebaseMessaging.instance.unsubscribeFromTopic('${AppConstants.TOPIC}-${Get.find<LocationController>().getUserAddress()!.zoneId!}');
        }
      }

    }
    apiClient.postData(AppConstants.TOKEN_URI, {"_method": "put", "fcm_token": '@'});
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    sharedPreferences.remove(AppConstants.USER_ADDRESS);
    sharedPreferences.remove(AppConstants.TOKEN);
    apiClient.token = null;
    return true;
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_NUMBER, number);

    } catch (e) {
      throw e;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserCountryCode() {
    return sharedPreferences.getString(AppConstants.USER_COUNTRY_CODE) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.NOTIFICATION) ?? true;
  }

  toggleNotificationSound(bool isNotification){
    sharedPreferences.setBool(AppConstants.NOTIFICATION, isNotification);
  }


  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    await sharedPreferences.remove(AppConstants.USER_COUNTRY_CODE);
    return await sharedPreferences.remove(AppConstants.USER_NUMBER);
  }

  bool clearSharedAddress(){
    sharedPreferences.remove(AppConstants.USER_ADDRESS);
    return true;
  }
}
