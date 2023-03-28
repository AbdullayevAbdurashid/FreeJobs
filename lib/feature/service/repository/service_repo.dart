import 'package:demandium/data/provider/client_api.dart';
import 'package:demandium/feature/review/model/review_body.dart';
import 'package:get/get.dart';
import 'package:demandium/utils/app_constants.dart';

class ServiceRepo extends GetxService {
  final ApiClient apiClient;
  ServiceRepo({required this.apiClient});

  Future<Response> getAllServiceList(int offset) async {
    return await apiClient.getData('${AppConstants.ALL_SERVICE_URI}?offset=$offset&limit=10');
  }
  Future<Response> getPopularServiceList(int offset) async {
    return await apiClient.getData('${AppConstants.POPULAR_SERVICE_URI}?offset=$offset&limit=10');
  }

  Future<Response> getTrendingServiceList(int offset) async {
    return await apiClient.getData('${AppConstants.TRENDING_SERVICE_URI}?offset=$offset&limit=10');
  }

  Future<Response> getRecentlyViewedServiceList(int offset) async {
    return await apiClient.getData('${AppConstants.RECENTLY_VIEWED_SERVICE_URI}?offset=$offset&limit=10');
  }


  Future<Response> getFeatheredCategoryServiceList() async {
    return await apiClient.getData('${AppConstants.GET_FEATHERED_SERVICE_CATEGORY}');
  }

  Future<Response> getRecommendedServiceList(int offset) async {
    return await apiClient.getData('${AppConstants.RECOMMENDED_SERVICE_URI}?limit=10&offset=$offset');
  }

  Future<Response> getRecommendedSearchList() async {
    return await apiClient.getData('${AppConstants.RECOMMENDED_SEARCH_URI}');
  }

  Future<Response> getOffersList(int offset) async {
    return await apiClient.getData('${AppConstants.OFFER_LIST_URI}?limit=10&offset=$offset');
  }

  Future<Response> getServiceListBasedOnSubCategory({required String subCategoryID, required int offset}) async {
    return await apiClient.getData('${AppConstants.SERVICE_BASED_ON_SUB_CATEGORY}$subCategoryID?limit=10&offset=$offset');
  }
  Future<Response> getItemsBasedOnCampaignId({required String campaignID}) async {
    return await apiClient.getData('${AppConstants.ITEMS_BASED_ON_CAMPAIGN_ID}$campaignID&limit=100&offset=1');
  }

  Future<Response> submitReview(ReviewBody reviewBody) async {
    return await apiClient.postData(AppConstants.SERVICE_REVIEW, reviewBody.toJson());
  }

}
