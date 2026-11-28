import 'package:material_ui/material_ui.dart';

import '../../l10n/app_localizations.dart';
import '../../models/app_user.dart';
import '../../models/verification_status.dart';
import '../../repositories/auth_repository.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension UserRoleL10n on UserRole {
  String label(AppLocalizations l10n) => switch (this) {
        UserRole.administrator => l10n.roleAdministrator,
        UserRole.maintenance => l10n.roleMaintenance,
        UserRole.hse => l10n.roleHse,
        UserRole.inspector => l10n.roleInspector,
      };
}

extension VerificationStatusL10n on VerificationStatus {
  String label(AppLocalizations l10n) => switch (this) {
        VerificationStatus.suspected => l10n.statusSuspected,
        VerificationStatus.documented => l10n.statusDocumented,
        VerificationStatus.physicallyVerified => l10n.statusPhysicallyVerified,
        VerificationStatus.rejected => l10n.statusRejected,
      };
}

extension AuthErrorL10n on AuthErrorCode {
  String message(AppLocalizations l10n) => switch (this) {
        AuthErrorCode.invalidCredentials => l10n.errorInvalidCredentials,
        AuthErrorCode.unavailableInDemoMode => l10n.errorUnavailableInDemo,
        AuthErrorCode.network => l10n.errorNetwork,
        AuthErrorCode.unknown => l10n.errorUnknown,
      };
}
