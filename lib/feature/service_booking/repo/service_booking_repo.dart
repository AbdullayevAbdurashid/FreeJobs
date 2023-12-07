import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/notification/repository/notification_repo.dart';


class ServiceBookingRepo{
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  ServiceBookingRepo({required this.sharedPreferences,required this.apiClient});


  Future<Response> placeBookingRequest({required String paymentMethod, required String userId,
    required String serviceAddressID,required String schedule,required String zoneId
  }) async {
    return await apiClient.postData(AppConstants.placeRequest, {
      "payment_method": paymentMethod,
      "user_id": userId,
      "service_address_id": serviceAddressID,
      "service_schedule": schedule,
      "zone_id": zoneId,
    });
  }

  Future<Response> getBookingList({required int offset, required String bookingStatus})async{
    return await apiClient.getData("${AppConstants.bookingList}?limit=10&offset=$offset&booking_status=$bookingStatus");
  }

  Future<Response> getBookingDetails({required String bookingID})async{
    return await apiClient.getData("${AppConstants.bookingDetails}/$bookingID");
  }
}