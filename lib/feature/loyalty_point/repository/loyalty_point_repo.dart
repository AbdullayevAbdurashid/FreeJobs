import 'package:demandium/data/provider/client_api.dart';
import 'package:demandium/utils/app_constants.dart';
import 'package:get/get.dart';

class LoyaltyPointRepo{
  final ApiClient apiClient;
  LoyaltyPointRepo({required this.apiClient});

  Future<Response> convertLoyaltyPoint(String point) async {
    return await apiClient.postData(AppConstants.CONVERT_LOYALTY_POINT_TO_WALLET,{"point":point});
  }

  Future<Response> getLoyaltyPointData(int offset) async {
    return await apiClient.getData(AppConstants.LOYALTY_POINT_TRANSACTION_DATA+"?limit=10&offset=$offset");
  }
}