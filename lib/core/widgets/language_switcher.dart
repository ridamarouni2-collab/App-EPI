import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/settings/application/settings_controller.dart';
import '../utils/l10n_extensions.dart';

/// Compact FR / AR toggle, usable before login.
class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key, this.foregroundColor});

  final Color? foregroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final current = ref.watch(settingsControllerProvider.select((s) => s.locale));
    return PopupMenuButton<String>(
      tooltip: l10n.language,
      initialValue: current.languageCode,
      onSelected: (code) =>
          ref.read(settingsControllerProvider.notifier).setLocale(Locale(code)),
      itemBuilder: (_) => [
        PopupMenuItem(value: 'fr', child: Text(l10n.languageFrench)),
        PopupMenuItem(value: 'ar', child: Text(l10n.languageArabic)),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.translate, size: 20, color: foregroundColor),
            const SizedBox(width: 6),
            Text(
              current.languageCode.toUpperCase(),
              style: TextStyle(color: foregroundColor, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
