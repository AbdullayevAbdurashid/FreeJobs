import 'package:demandium/feature/checkout/repo/schedule_repo.dart';
import 'package:get/get.dart';
import 'package:demandium/feature/checkout/controller/schedule_controller.dart';

class CheckoutBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => ScheduleController(scheduleRepo: ScheduleRepo(apiClient: Get.find())));
  }

}