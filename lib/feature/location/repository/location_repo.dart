import 'package:get/get_connect/http/src/response/response.dart';
import 'package:demandium/core/core_export.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.addressUri);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstants.zoneUri}?lat=$lat&lng=$lng',headers: AppConstants.configHeader);
  }

  Future<Response> removeAddressByID(List<int> id) async {
    return await apiClient.postData(AppConstants.addressUri, {
      '_method': 'delete',
      'address_ids': id,
    });
  }

  Future<Response> addAddress(AddressModel addressModel) async {

    return await apiClient.postData(AppConstants.addressUri, addressModel.toJson());
  }

  Future<Response> updateAddress(AddressModel addressModel, int addressId) async {
    return await apiClient.putData('${AppConstants.addressUri}/$addressId', addressModel.toJson());
  }

  Future<bool> saveUserAddress(String address, String? zoneIDs) async {
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.token), zoneIDs,
      sharedPreferences.getString(AppConstants.languageCode),
    );
    return await sharedPreferences.setString(AppConstants.userAddress, address);
  }



  Future<Response> getAddressFromGeocode(LatLng? latLng) async {

    return await apiClient.getData('${AppConstants.geocodeUri}?lat=${latLng!.latitude}&lng=${latLng.longitude}',headers: AppConstants.configHeader);
  }

  String? getUserAddress() {
    return sharedPreferences.getString(AppConstants.userAddress);
  }

  Future<Response> searchLocation(String text) async {
    return await apiClient.getData('${AppConstants.searchLocationUri}?search_text=$text');
  }

  Future<Response> getPlaceDetails(String placeID) async {
    return await apiClient.getData('${AppConstants.placeDetailsUri}?placeid=$placeID');
  }

  Future<Response> changePostServiceAddress(String postId, String addressId) async {
    return await apiClient.postData(AppConstants.updatePostInfo,{
      "_method":"put",
      "post_id":postId,
      "service_address_id": addressId
    });
  }

}
