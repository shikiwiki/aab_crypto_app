extension StringHelper on String {
  bool get isValidEmail {
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final RegExp passwordRegExp = RegExp(r'^[A-Za-z0-9.]+$');
    return passwordRegExp.hasMatch(this);
  }

  String cleanInput() {
    return replaceAll(RegExp(r'[^0-9.]'), '');
  }
}
