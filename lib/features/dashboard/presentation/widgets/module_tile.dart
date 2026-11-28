import 'package:material_ui/material_ui.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/l10n_extensions.dart';

/// Entry to a feature module. Modules not yet implemented are rendered
/// visibly disabled with their planned phase: no fake navigation.
class ModuleTile extends StatelessWidget {
  const ModuleTile({
    super.key,
    required this.label,
    required this.icon,
    required this.plannedPhase,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final int plannedPhase;

  /// Null while the module is not available.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final available = onTap != null;
    final fg = available
        ? theme.colorScheme.onSurface
        : theme.colorScheme.onSurface.withValues(alpha: 0.45);
    return Semantics(
      button: available,
      enabled: available,
      label: available ? label : '$label. ${l10n.moduleNotYetAvailable(plannedPhase)}',
      excludeSemantics: true,
      child: Tooltip(
        message: available ? label : l10n.moduleNotYetAvailable(plannedPhase),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 30, color: available ? AppColors.green : fg),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(color: fg),
                  ),
                  if (!available) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock_clock_outlined, size: 12, color: fg),
                          const SizedBox(width: 4),
                          Text(
                            l10n.availableInPhase(plannedPhase),
                            style: theme.textTheme.labelSmall?.copyWith(color: fg),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
