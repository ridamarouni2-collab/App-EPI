import 'package:material_ui/material_ui.dart';

import '../../app/theme.dart';
import '../../models/verification_status.dart';

/// Color code shared by map, AR overlays and lists:
/// orange = suspected, blue = documented, green = physically verified.
extension VerificationStatusColor on VerificationStatus {
  Color get color => switch (this) {
        VerificationStatus.suspected => AppColors.orange,
        VerificationStatus.documented => AppColors.documentedBlue,
        VerificationStatus.physicallyVerified => AppColors.green,
        VerificationStatus.rejected => AppColors.rejectedGrey,
      };

  IconData get icon => switch (this) {
        VerificationStatus.suspected => Icons.help_outline,
        VerificationStatus.documented => Icons.description_outlined,
        VerificationStatus.physicallyVerified => Icons.verified_outlined,
        VerificationStatus.rejected => Icons.block,
      };
}

class Pill extends StatelessWidget {
  const Pill({super.key, required this.label, required this.color, this.icon});

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 5),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class DemoBadge extends StatelessWidget {
  const DemoBadge({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) =>
      Pill(label: label, color: AppColors.orange, icon: Icons.science_outlined);
}
