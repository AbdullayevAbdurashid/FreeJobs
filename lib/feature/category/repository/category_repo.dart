import 'package:get/get_connect/http/src/response/response.dart';
import 'package:demandium/core/core_export.dart';

class CategoryRepo {
  final ApiClient apiClient;
  CategoryRepo({required this.apiClient});

  Future<Response> getCategoryList(int offset) async {
    return await apiClient.getData('${AppConstants.CATEGORY_URI}&limit=100&offset=$offset');
  }

  Future<Response> getItemsBasedOnCampaignId({required String campaignID}) async {
    return await apiClient.getData('${AppConstants.ITEMS_BASED_ON_CAMPAIGN_ID}$campaignID&limit=100&offset=1');
  }

  Future<Response> getSubCategoryList(String parentID) async {
    return await apiClient.getData('${AppConstants.SUB_CATEGORY_URI}$parentID');
  }

  Future<Response> getCategoryServiceList(String categoryID, int offset, String type) async {
    return await apiClient.getData('${AppConstants.CATEGORY_SERVICE_URI}$categoryID?limit=10&offset=$offset&type=$type');
  }


  Future<Response> getSearchData(String query, String categoryID, String type) async {
    return await apiClient.getData(
      '${AppConstants.SEARCH_URI}services/search?name=$query&category_id=$categoryID&type=$type&offset=1&limit=50',
    );
  }
}