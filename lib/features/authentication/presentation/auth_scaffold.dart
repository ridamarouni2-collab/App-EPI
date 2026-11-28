import 'package:material_ui/material_ui.dart';

import '../../../app/theme.dart';
import '../../../core/utils/l10n_extensions.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/language_switcher.dart';

/// Shared layout for login / password-reset: navy header + centered card.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 290,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.navy, AppColors.navyLight],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: LanguageSwitcher(foregroundColor: Colors.white),
                ),
                Expanded(
                  // Top-aligned (not centered) so the white logo/title always
                  // sit on the navy header, whatever the screen height.
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 440),
                        child: Column(
                          children: [
                            const AppLogo(size: 76),
                            const SizedBox(height: 14),
                            Text(
                              l10n.appName,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: 24),
                            Card(
                              elevation: 6,
                              shadowColor: Colors.black26,
                              child: Padding(
                                padding: const EdgeInsets.all(22),
                                child: child,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
