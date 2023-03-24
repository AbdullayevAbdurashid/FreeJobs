import 'package:get/get.dart';

List<Map<String, String>> onBoardPagerData = [
  {
    "text": 'on_boarding_1_title'.tr,
    "subTitle": 'on_boarding_data_1'.tr,
    "image": Get.isDarkMode ? "assets/images/onboard_dark.gif": "assets/images/onboard_light.gif"
  },
  {
    "text": 'on_boarding_2_title'.tr,
    "subTitle": 'on_boarding_data_2'.tr,
    "image":Get.isDarkMode ? "assets/images/onboard_dark_two.gif" : "assets/images/onboard_light_two.gif"
  }
];