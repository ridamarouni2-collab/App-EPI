import 'package:intl/intl.dart' show DateFormat;
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/l10n_extensions.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../models/dashboard_snapshot.dart';

extension on ActivityType {
  (IconData, Color) get visual => switch (this) {
        ActivityType.inspection => (Icons.fact_check_outlined, AppColors.documentedBlue),
        ActivityType.scanSession => (Icons.photo_camera_outlined, AppColors.green),
        ActivityType.riskZone => (Icons.dangerous_outlined, AppColors.red),
        ActivityType.network => (Icons.timeline, AppColors.orange),
        ActivityType.report => (Icons.picture_as_pdf_outlined, AppColors.navyLight),
      };

  String label(AppLocalizations l10n) => switch (this) {
        ActivityType.inspection => l10n.activityInspection,
        ActivityType.scanSession => l10n.activityScanSession,
        ActivityType.riskZone => l10n.activityRiskZone,
        ActivityType.network => l10n.activityNetwork,
        ActivityType.report => l10n.activityReport,
      };
}

class ActivityTile extends StatelessWidget {
  const ActivityTile({super.key, required this.entry});

  final ActivityEntry entry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final (icon, color) = entry.type.visual;
    final date = DateFormat.yMMMd(locale).add_Hm().format(entry.timestamp);
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.14),
            foregroundColor: color,
            child: Icon(icon),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(entry.type.label(l10n),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall),
                    ),
                    if (entry.isDemo) ...[
                      const SizedBox(width: 8),
                      DemoBadge(label: l10n.demoBadge),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                // Business references are Latin identifiers: keep them LTR.
                Text(entry.reference,
                    textDirection: TextDirection.ltr,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(entry.siteName, style: muted),
                Text('${entry.actorName} — $date', style: muted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
