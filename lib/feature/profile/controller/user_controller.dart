import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

   UserInfoModel _userInfoModel = UserInfoModel();

   String fName='';
   String lName='';
   String email='';
   String phone='';
   XFile? _pickedFile ;
   FilePickerResult? _selectedFile;
   bool _isLoading = false;

  UserInfoModel get userInfoModel => _userInfoModel;
  XFile? get pickedFile => _pickedFile;
  bool get isLoading => _isLoading;
  int _year = 0;
  int get year => _year;

  int _month = 0;
  int get month => _month;

  int _day = 0;
  int get day => _day;
  final now = new DateTime.now();
  String _createdAccountAgo ='';
  String get createdAccountAgo => _createdAccountAgo;

  String _userProfileImage = '';
  String get userProfileImage => _userProfileImage;

  Future<void> getUserInfo() async {
    _isLoading = true;
    Response response = await userRepo.getUserInfo();
    if (response.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(response.body['content']);
      _userProfileImage = _userInfoModel.image!;
      fName = _userInfoModel.fName??'';
      lName = _userInfoModel.lName??'';
      email = _userInfoModel.email??'';
      phone = _userInfoModel.phone??'';
       final difference= now.difference(DateConverter.isoUtcStringToLocalDate(response.body['content']['created_at']));
       print(_createdAccountAgo);
      _createdAccountAgo =  timeago.format(now.subtract(difference));
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<ResponseModel> changePassword(UserInfoModel updatedUserModel) async {
    _isLoading = true;
    update();
    ResponseModel _responseModel;
    Response response = await userRepo.changePassword(updatedUserModel);
    if (response.statusCode == 200) {
      String message = response.body["message"];
      _responseModel = ResponseModel(true, message);
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(response.body['message']),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ));
    } else {
      _responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return _responseModel;
  }

  void pickImage() async {
    _pickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    update();
  }


  void pickFile() async {
    _selectedFile = (await FilePicker.platform.pickFiles())!;
    print(_selectedFile!.files.single.name);
    update();
  }

  void initData() {
  }

  Future removeUser() async {
    _isLoading = true;
    update();
    Response response = await userRepo.deleteUser();
    _isLoading = false;
    if(response.statusCode == 200){
      customSnackBar('your_account_remove_successfully'.tr);
      Get.find<AuthController>().clearSharedData();
      Get.find<CartController>().clearCartList();
      Get.find<AuthController>().googleLogout();
      Get.find<AuthController>().signOutWithFacebook();
      Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
    }else{
      Get.back();
      ApiChecker.checkApi(response);
    }
  }
}