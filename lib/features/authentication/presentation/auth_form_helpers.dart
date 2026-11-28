import '../../../core/constants/app_constants.dart';
import '../../../core/utils/validators.dart';
import '../../../l10n/app_localizations.dart';

String? emailErrorText(AppLocalizations l10n, String? value) =>
    switch (Validators.email(value)) {
      ValidationError.required => l10n.emailRequired,
      ValidationError.invalidEmail => l10n.emailInvalid,
      _ => null,
    };

String? passwordErrorText(AppLocalizations l10n, String? value) =>
    switch (Validators.password(value)) {
      ValidationError.required => l10n.passwordRequired,
      ValidationError.tooShort =>
        l10n.passwordTooShort(AppConstants.minPasswordLength),
      _ => null,
    };
