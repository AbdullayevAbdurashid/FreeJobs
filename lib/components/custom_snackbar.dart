import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

void customSnackBar(String? message, {bool isError = true, double margin = Dimensions.PADDING_SIZE_SMALL}) {
  if(message != null && message.isNotEmpty) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      message: message,
      maxWidth: Dimensions.WEB_MAX_WIDTH,
      duration: Duration(seconds: 2),
      snackStyle: SnackStyle.FLOATING,
      margin: EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_SMALL,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          bottom: margin),
      borderRadius: Dimensions.RADIUS_SMALL,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}