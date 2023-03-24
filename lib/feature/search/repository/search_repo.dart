import 'package:demandium/feature/notification/repository/notification_repo.dart';
import 'dart:convert';
import 'package:demandium/core/core_export.dart';

class SearchRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getSearchData(String query) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(query);
    return await apiClient.getData('${AppConstants.SEARCH_URI}?string=$encoded&offset=1&limit=50');
  }

  Future<bool> saveSearchHistory(List<String> searchHistories) async {
    return await sharedPreferences.setStringList(AppConstants.SEARCH_HISTORY, searchHistories);
  }

  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.SEARCH_HISTORY) ?? [];
  }

  Future<bool> clearSearchHistory() async {
    return sharedPreferences.setStringList(AppConstants.SEARCH_HISTORY, []);
  }

  Future<Response> getSuggestedServicesFromServer() async {
    return await apiClient.getData('${AppConstants.SUGGESTED_SEARCH_URI}?offset=1&limit=20');
  }

  Future<Response> removeSuggestedServicesFromServer({String? id}) async {
    return await apiClient.getData('${AppConstants.REMOVE_SUGGESTED_SEARCH_URI}${id!=null?'?id[]=$id':''}');
  }
}
