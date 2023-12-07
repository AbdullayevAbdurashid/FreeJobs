import 'package:get/get_connect/http/src/response/response.dart';
import 'package:demandium/data/provider/client_api.dart';
import 'package:demandium/utils/app_constants.dart';

class CouponRepo {
  final ApiClient apiClient;
  CouponRepo({required this.apiClient});

  Future<Response> getCouponList() async {
    return await apiClient.getData(AppConstants.couponUri);
  }

  Future<Response> applyCoupon(String couponCode) async {
    return await apiClient.postData(AppConstants.applyCoupon,{'coupon_code':couponCode});
  }

  Future<Response> removeCoupon() async {
    return await apiClient.getData(AppConstants.removeCoupon);
  }
}