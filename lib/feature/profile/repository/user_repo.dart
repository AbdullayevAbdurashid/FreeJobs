import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:demandium/core/core_export.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.CUSTOMER_INFO_URI);
  }

  Future<Response> updateProfile(UserInfoModel userInfoModel, XFile? data) async {
    Map<String, String> _body = Map();
    _body.addAll(<String, String>{
      '_method': 'put',
      'first_name': userInfoModel.fName!,
      'last_name': userInfoModel.lName!,
      'email': userInfoModel.email!,
      'phone': userInfoModel.phone!,
    });
    return await apiClient.postMultipartData(AppConstants.UPDATE_PROFILE_URI, _body,data != null ? [MultipartBody('profile_image', data)]:[]);
  }

  Future<Response> updateAccountInfo(UserInfoModel userInfoModel) async {
    Map<String, String> _body = Map();
    _body.addAll(<String, String>{
      '_method': 'put',
      'first_name': userInfoModel.fName!,
      'last_name': userInfoModel.lName!,
      'email': userInfoModel.email!,
      'phone': userInfoModel.phone!,
      'password': userInfoModel.password!,
      'confirm_password': userInfoModel.confirmPassword!,
    });
    return await apiClient.putData(AppConstants.UPDATE_PROFILE_URI, _body);
  }

  Future<Response> changePassword(UserInfoModel userInfoModel) async {
    return await apiClient.postData(AppConstants.UPDATE_PROFILE_URI, {'phone_or_email': userInfoModel.fName, 'otp': userInfoModel.lName,
      'password': userInfoModel.email, 'confirm_password': userInfoModel.phone});
  }

  Future<Response> deleteUser() async {
    return await apiClient.deleteData(AppConstants.CUSTOMER_REMOVE);
  }

}