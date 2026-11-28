import '../constants/app_constants.dart';

/// Pure validation helpers. They return an error *code* so the UI layer can
/// map it to a localized message.
enum ValidationError { required, invalidEmail, tooShort }

abstract final class Validators {
  static final _emailRegExp = RegExp(r"^[\w.+\-']+@[\w\-]+(\.[\w\-]+)+$");

  static ValidationError? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return ValidationError.required;
    if (!_emailRegExp.hasMatch(v)) return ValidationError.invalidEmail;
    return null;
  }

  static ValidationError? password(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return ValidationError.required;
    if (v.length < AppConstants.minPasswordLength) return ValidationError.tooShort;
    return null;
  }
}
