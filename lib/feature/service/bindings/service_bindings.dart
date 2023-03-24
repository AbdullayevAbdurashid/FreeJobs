import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ServiceBinding extends Bindings{
  @override
  void dependencies() async {

    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);
    Get.lazyPut(() => ServiceController(
        serviceRepo: ServiceRepo(apiClient: ApiClient(
           appBaseUrl: AppConstants.BASE_URL,
           sharedPreferences: sharedPreferences))
    ));
  }
}