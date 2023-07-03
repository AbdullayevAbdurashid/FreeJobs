import 'package:get/get.dart';


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

  String? isValidEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'enter_valid_email_address'.tr;
    }
    return null;
  }
}