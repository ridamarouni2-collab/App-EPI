import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/l10n_extensions.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/status_chip.dart';
import '../../authentication/application/auth_providers.dart';
import '../application/settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.signOut),
        content: Text(l10n.signOutConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
          FilledButton(
            key: const Key('settings.confirmSignOut'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.red,
              minimumSize: const Size(0, 44),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.signOut),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(authRepositoryProvider).signOut();
      if (context.mounted) context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (user != null) ...[
                _Section(l10n.account),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.navy,
                      foregroundColor: Colors.white,
                      child: Text(user.initials),
                    ),
                    title: Text(user.displayName),
                    subtitle: Text('${user.email}\n${user.role.label(l10n)}'),
                    isThreeLine: true,
                    trailing: user.isDemo ? DemoBadge(label: l10n.demoBadge) : null,
                  ),
                ),
              ],
              _Section(l10n.language),
              Card(
                child: RadioGroup<String>(
                  groupValue: settings.locale.languageCode,
                  onChanged: (v) {
                    if (v != null) controller.setLocale(Locale(v));
                  },
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        key: const Key('settings.lang.fr'),
                        value: 'fr',
                        title: Text(l10n.languageFrench),
                      ),
                      RadioListTile<String>(
                        key: const Key('settings.lang.ar'),
                        value: 'ar',
                        title: Text(l10n.languageArabic),
                      ),
                    ],
                  ),
                ),
              ),
              _Section(l10n.theme),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SegmentedButton<ThemeMode>(
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: const Icon(Icons.brightness_auto_outlined),
                        label: Text(l10n.themeSystem),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: const Icon(Icons.light_mode_outlined),
                        label: Text(l10n.themeLight),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: const Icon(Icons.dark_mode_outlined),
                        label: Text(l10n.themeDark),
                      ),
                    ],
                    selected: {settings.themeMode},
                    onSelectionChanged: (s) => controller.setThemeMode(s.first),
                  ),
                ),
              ),
              _Section(l10n.demoData),
              Card(
                child: SwitchListTile(
                  key: const Key('settings.demoData'),
                  secondary: const Icon(Icons.science_outlined, color: AppColors.orange),
                  title: Text(l10n.demoData),
                  subtitle: Text(l10n.demoDataDescription),
                  value: settings.showDemoData,
                  onChanged: controller.setShowDemoData,
                ),
              ),
              _Section(l10n.about),
              Card(
                child: ListTile(
                  leading: const AppLogo(size: 40),
                  title: Text(l10n.appName),
                  subtitle: Text(l10n.version(AppConstants.appVersion)),
                ),
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                key: const Key('settings.signOut'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.red,
                  side: const BorderSide(color: AppColors.red),
                ),
                onPressed: () => _confirmSignOut(context, ref),
                icon: const Icon(Icons.logout),
                label: Text(l10n.signOut),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.hseWarning,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(color: AppColors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.only(start: 4, top: 18, bottom: 8),
        child: Text(text, style: Theme.of(context).textTheme.titleSmall),
      );
}
