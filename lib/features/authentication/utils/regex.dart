final emailRegEx = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);

final passwordRegEx = RegExp(r'^(?=.*[a-zA-Z])[a-zA-Z0-9]*.{8,14}$');
