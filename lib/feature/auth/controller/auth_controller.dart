import 'package:get/get.dart';
import 'package:demandium/core/common_model/errrors_model.dart';
import 'package:demandium/core/core_export.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;


  bool? _isLoading = false;
  bool _acceptTerms = false;

  AuthController({required this.authRepo});
  bool? get isLoading => _isLoading;
  bool get acceptTerms => _acceptTerms;

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var countryDialCodeForSignup;

  var signInPhoneController = TextEditingController();
  var signInPasswordController = TextEditingController();
  var countryDialCodeForSignIn;

  var contactNumberController = TextEditingController();
  var countryDialCode;
  String _mobileNumber = '';
  String get mobileNumber => _mobileNumber;

  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    phoneController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    contactNumberController.text = '';
    newPasswordController.text = '';
    confirmNewPasswordController.text = '';
    contactNumberController.text = '';
    signInPhoneController.text =  getUserNumber();
    signInPasswordController.text = getUserPassword();
    countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content != null ? Get.find<SplashController>().configModel.content!.countryCode!:"BD").dialCode;
    countryDialCodeForSignup = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content != null ? Get.find<SplashController>().configModel.content!.countryCode!:"BD").dialCode;
    countryDialCodeForSignIn = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content != null ? Get.find<SplashController>().configModel.content!.countryCode!:"BD").dialCode;
  }

  onClose() {
    super.onClose();

  }

  fetchUserNamePassword(){
    signInPhoneController.text =  getUserNumber();
    signInPasswordController.text = getUserPassword();
  }


  Future<void> registration() async {
    String _numberWithCountryCode = countryDialCodeForSignup + phoneController.value.text;

    bool _isValid = GetPlatform.isWeb ? true : false;
    if(!GetPlatform.isWeb){
      try{
        _isValid = await PhoneNumberUtil().validate(_numberWithCountryCode);
      }catch (e){

      }
    }

    if(_isValid){
      SignUpBody signUpBody = SignUpBody(
          fName: firstNameController.value.text,
          lName: lastNameController.value.text,
          email: emailController.value.text,
          phone: _numberWithCountryCode,
          password: passwordController.value.text,
          confirmPassword: confirmPasswordController.value.text);
      _isLoading = false;
      update();
      Response? response = await authRepo.registration(signUpBody);
      if (response!.statusCode == 200) {
        if(response.body['response_code'] == 'registration_200') {
          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          phoneController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.main));
        }
        customSnackBar('registration_200'.tr,isError:false);
      }
      else {
        ErrorsModel _errorResponse = ErrorsModel.fromJson(response.body);
        customSnackBar('${_errorResponse.responseCode}_${_errorResponse.errors!.elementAt(0).errorCode!}'.tr);
      }
      _isLoading = false;
      update();
    }else{
      customSnackBar('phone_number_with_valid_country_code'.tr);
    }
  }

  Future<void> login() async {
    String _numberWithCountryCode = signInPhoneController.value.text;
      _isLoading = true;
      update();
      Response? response = await authRepo.login(phone: _numberWithCountryCode, password: signInPasswordController.value.text);
      if (response!.statusCode == 200) {
        authRepo.saveUserToken(response.body['content']['token']);
        await authRepo.updateToken();
        _navigateLogin();
        Get.find<CartController>().getCartData().then((cartList){
          if(cartList.length > 0) {
            Get.find<CartController>().addMultipleCartToServer().then((value) {
            }).then((value) => Get.find<CartController>().getCartListFromServer());
          }

        });
      }else{
        customSnackBar(response.statusText!.tr);
      }
      _isLoading = false;
      update();

  }
  _navigateLogin(){
    Get.offAllNamed(RouteHelper.getInitialRoute());
    if (_isActiveRememberMe) {
      saveUserNumberAndPassword(signInPhoneController.value.text, signInPasswordController.value.text);
    } else {
      clearUserNumberAndPassword();
    }
    signInPhoneController.clear();
    signInPasswordController.clear();
  }



  Future<void> loginWithSocialMedia(SocialLogInBody socialLogInBody) async {

    Get.dialog(CustomLoader(), barrierDismissible: false,);

    Response? response = await authRepo.loginWithSocialMedia(socialLogInBody);
    print(response!.body);
    if (response.statusCode == 200) {
      String _token = response.body['content']['token'];
      if(_token.isNotEmpty) {
        if(response.body['content']['is_active'] == 1) {
          authRepo.saveUserToken(response.body['content']['token']);
          await authRepo.updateToken();
          Get.offAllNamed(RouteHelper.getInitialRoute());
        }
      }
    } else {
      customSnackBar(response.statusText!);
    }
    Get.back();
  }

  Future<void> forgetPassword() async {
    String _numberWithCountryCode = countryDialCode + contactNumberController.value.text;
    _mobileNumber = _numberWithCountryCode;
    _isLoading = true;
    update();
    Response? response = await authRepo.forgetPassword(_numberWithCountryCode);
    if (response!.body['response_code'] == 'default_200') {
      _isLoading = false;
      customSnackBar('successfully_sent_otp'.tr, isError: false);
      Get.toNamed(RouteHelper.getVerificationRoute(_numberWithCountryCode));
    }else{
      _isLoading = false;
      customSnackBar('invalid_number'.tr);
    }
    update();
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  Future<void> verifyToken(String phoneOrEmail) async {
    Response? response = await authRepo.verifyToken(phoneOrEmail, _verificationCode);
    print(response!.body);
    if (response.body['response_code'] == 'default_verified_200') {
      Navigator.popAndPushNamed(Get.context!, RouteHelper.getResetPasswordRoute(phoneOrEmail.substring(1,phoneOrEmail.length-1), _verificationCode));
      customSnackBar('${response.body['response_code']}'.tr, isError: false);
    }else{
      customSnackBar('invalid_otp'.tr);
    }
    _isLoading = false;
    update();
  }

  Future<void> resetPassword(String phoneOrEmail) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.resetPassword(_mobileNumber, _otp, newPasswordController.value.text, confirmNewPasswordController.value.text);
    if (response!.body['response_code'] == 'default_password_reset_200') {
      contactNumberController.clear();
      newPasswordController.clear();
      confirmNewPasswordController.clear();
      Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
      customSnackBar('password_change_successfully'.tr, isError: false);
    }else{
      customSnackBar(response.body['message']);
    }
    _isLoading = false;
    update();
  }



  Future<ResponseModel> checkEmail(String email) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.checkEmail(email);
    ResponseModel responseModel;
    if (response!.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> verifyEmail(String email, String token) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.verifyEmail(email, _verificationCode);
    ResponseModel responseModel;
    if (response!.statusCode == 200) {
      authRepo.saveUserToken(token);
      await authRepo.updateToken();
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> verifyPhone(String phone, String token) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.verifyPhone(phone, _verificationCode);
    ResponseModel responseModel;
    if (response!.statusCode == 200) {
      authRepo.saveUserToken(token);
      await authRepo.updateToken();
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> updateZone() async {
    Response? response = await authRepo.updateZone();
    if (response!.statusCode == 200) {
      // Nothing to do
    } else {
      ApiChecker.checkApi(response);
    }
  }

  String _verificationCode = '';
  String _otp = '';
  String get otp => _otp;
  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    if(_verificationCode.isNotEmpty){
    _otp = _verificationCode;
    }
    update();
  }


  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserCountryCode() {
    return authRepo.getUserCountryCode();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }
  bool isNotificationActive() {
    return authRepo.isNotificationActive();

  }
  toggleNotificationSound(){
    authRepo.toggleNotificationSound(!isNotificationActive());
    update();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }


  GoogleSignIn? _googleSignIn = GoogleSignIn();


  // GoogleSignIn? _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;
  GoogleSignInAuthentication? auth;

  Future<void> socialLogin() async {
    this.googleAccount = (await _googleSignIn!.signIn())!;
    auth = await googleAccount!.authentication;
    update();
  }



  Future<void> googleLogout() async {
    try{
      this.googleAccount = (await _googleSignIn!.disconnect())!;
      auth = await googleAccount!.authentication;
    }catch(e){}
  }


  Future<void> signOutWithFacebook() async {
    await FacebookAuth.instance.logOut();
  }

  void initCountryCode(){
    countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content != null ? Get.find<SplashController>().configModel.content!.countryCode!:"BD").dialCode;
    countryDialCodeForSignup = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content?.countryCode??"BD").dialCode;
    countryDialCodeForSignIn = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content != null ? Get.find<SplashController>().configModel.content!.countryCode!:"BD").dialCode;
  }
}