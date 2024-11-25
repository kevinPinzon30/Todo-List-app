import 'string_custom_getters.dart';

class ValidationMethods {
  static String? validateMail(String? value) {
    if (value!.isEmpty) return "Enter your Email";

    if (!value.isValidEmail) return "Enter a valid email";

    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) return "Enter your password";

    if (!value.isValidPassword) return "Enter a valid password";

    return null;
  }
}
