import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

void customSnackBar(String? message, {bool isError = true, double margin = Dimensions.paddingSizeSmall,int duration =2}) {
  if(message != null && message.isNotEmpty) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      message: message,
      maxWidth: Dimensions.webMaxWidth,
      duration: Duration(seconds: duration),
      snackStyle: SnackStyle.FLOATING,
      margin: EdgeInsets.only(
          top: Dimensions.paddingSizeSmall,
          left: Dimensions.paddingSizeSmall,
          right: Dimensions.paddingSizeSmall,
          bottom: margin),
      borderRadius: Dimensions.radiusSmall,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}