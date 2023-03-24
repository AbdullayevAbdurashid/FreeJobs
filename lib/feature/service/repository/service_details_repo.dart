import 'package:demandium/data/provider/client_api.dart';
import 'package:get/get.dart';
import 'package:demandium/utils/app_constants.dart';

class ServiceDetailsRepo extends GetxService {
  final ApiClient apiClient;
  ServiceDetailsRepo({required this.apiClient});

  Future<Response> getServiceDetails(String serviceID) async {
    return await apiClient.getData('${AppConstants.SERVICE_DETAILS_URI}/$serviceID');
  }

  Future<Response> getServiceReviewList(String serviceID,int offset) async {
    return await apiClient.getData('${AppConstants.GET_SERVICE_REVIEW_LIST}$serviceID?offset=$offset&limit=10');
  }

}
