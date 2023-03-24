import 'package:get/get_utils/src/extensions/internacionalization.dart';

class FormValidation {
  String? isValidLength(String value) {
    if (value.length<=2) {
      return 'enter_valid_information'.tr;
    }
    return null;
  }
  String? isValidFirstName(String value) {
    if (value.length<=2) {
      return 'enter_your_first_name'.tr;
    }
    return null;
  }
  String? isValidLastName(String value) {
    if (value.length<=2) {
      return 'enter_your_last_name'.tr;
    }
    return null;
  }
  String? isValidPassword(String value) {
    if (value.length<=7) {
      return 'password_should_be'.tr;
    }
    return null;
  }
}