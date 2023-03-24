import 'package:get/get_connect/http/src/response/response.dart';
import 'package:demandium/core/core_export.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.ADDRESS_URI);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng',headers: AppConstants.configHeader);
  }

  Future<Response> removeAddressByID(List<int> id) async {
    return await apiClient.postData('${AppConstants.ADDRESS_URI}', {
      '_method': 'delete',
      'address_ids': id,
    });
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    print("inside_add_address");
    print(addressModel.toJson());
    return await apiClient.postData(AppConstants.ADDRESS_URI, addressModel.toJson());
  }

  Future<Response> updateAddress(AddressModel addressModel, int addressId) async {
    return await apiClient.putData('${AppConstants.ADDRESS_URI}/$addressId', addressModel.toJson());
  }

  Future<bool> saveUserAddress(String address, String? zoneIDs) async {
    print("inside_save_user_address");
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN), zoneIDs,
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
    );
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }



  Future<Response> getAddressFromGeocode(LatLng? latLng) async {

    return await apiClient.getData('${AppConstants.GEOCODE_URI}?lat=${latLng!.latitude}&lng=${latLng.longitude}',headers: AppConstants.configHeader);
  }

  String? getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS);
  }

  Future<Response> searchLocation(String text) async {
    return await apiClient.getData('${AppConstants.SEARCH_LOCATION_URI}?search_text=$text');
  }

  Future<Response> getPlaceDetails(String placeID) async {
    return await apiClient.getData('${AppConstants.PLACE_DETAILS_URI}?placeid=$placeID');
  }

}
