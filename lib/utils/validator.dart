String validate(String value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

String validateEmail(String value) {
  String message = validate(value);
  Pattern pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  if (!RegExp(pattern).hasMatch(value)) {
    message = 'Invalid Email';
  }

  return message;
}

String validatePassword(String value) {
  String message;
  if (value != null) {
    if(value.length < 6){
      message = 'Weak password';
    }
  }
  message = validate(value);

  if (message != null) {
    message = 'Invalid password';
  }

  return message;
}

String validateBloodGroup(String value) {
  String message = validate(value);
  Pattern pattern = r"^(A|B|AB|O)[+-]$";
  if (!RegExp(pattern).hasMatch(value)) {
    message = 'Invalid Blood Group';
  }

  return message;
}
