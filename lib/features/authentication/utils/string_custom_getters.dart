
import 'regex.dart';

extension CustomStringGetters on String {
  bool get isValidEmail {
    return emailRegEx.hasMatch(this);
  }

  bool get isValidPassword {
    return passwordRegEx.hasMatch(this);
  }

}
