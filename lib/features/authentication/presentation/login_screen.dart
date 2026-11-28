import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../core/utils/l10n_extensions.dart';
import '../../../core/widgets/notice_banner.dart';
import '../../../repositories/auth_repository.dart';
import '../../../repositories/local_demo_auth_repository.dart';
import '../application/auth_providers.dart';
import 'auth_form_helpers.dart';
import 'auth_scaffold.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  AuthErrorCode? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(authRepositoryProvider).signInWithEmail(
            email: _email.text.trim(),
            password: _password.text,
          );
      // Router redirect sends the user to the dashboard.
      if (mounted) context.go(AppRoutes.dashboard);
    } on AuthException catch (e) {
      if (mounted) setState(() => _error = e.code);
    } catch (_) {
      if (mounted) setState(() => _error = AuthErrorCode.unknown);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _fillDemo(String email) {
    _email.text = email;
    _password.text = LocalDemoAuthRepository.demoPassword;
    setState(() => _error = null);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isDemo = ref.watch(authRepositoryProvider).isDemo;

    return AuthScaffold(
      child: Form(
        key: _formKey,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.loginTitle, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(
                l10n.loginSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 22),
              TextFormField(
                key: const Key('login.email'),
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                enabled: !_loading,
                decoration: InputDecoration(
                  labelText: l10n.emailLabel,
                  prefixIcon: const Icon(Icons.alternate_email),
                ),
                validator: (v) => emailErrorText(l10n, v),
              ),
              const SizedBox(height: 14),
              TextFormField(
                key: const Key('login.password'),
                controller: _password,
                obscureText: _obscure,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                enabled: !_loading,
                onFieldSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  labelText: l10n.passwordLabel,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    tooltip: _obscure ? l10n.showPassword : l10n.hidePassword,
                    icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                validator: (v) => passwordErrorText(l10n, v),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: _loading
                      ? null
                      : () => context.push(Uri(
                            path: AppRoutes.forgotPassword,
                            queryParameters: _email.text.trim().isEmpty
                                ? null
                                : {'email': _email.text.trim()},
                          ).toString()),
                  child: Text(l10n.forgotPassword),
                ),
              ),
              if (_error != null) ...[
                NoticeBanner(kind: NoticeKind.danger, message: _error!.message(l10n)),
                const SizedBox(height: 14),
              ],
              FilledButton(
                key: const Key('login.submit'),
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const SizedBox.square(
                        dimension: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                      )
                    : Text(l10n.signIn),
              ),
              if (isDemo) ...[
                const SizedBox(height: 22),
                _DemoAccountsPanel(onSelect: _fillDemo, enabled: !_loading),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoAccountsPanel extends StatelessWidget {
  const _DemoAccountsPanel({required this.onSelect, required this.enabled});

  final ValueChanged<String> onSelect;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        NoticeBanner(
          kind: NoticeKind.demo,
          title: l10n.demoModeTitle,
          message: l10n.demoModeBody(LocalDemoAuthRepository.demoPassword),
        ),
        const SizedBox(height: 8),
        ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 4),
          shape: const Border(),
          leading: const Icon(Icons.groups_outlined, color: AppColors.orange),
          title: Text(l10n.demoAccountsTitle),
          children: [
            for (final a in LocalDemoAuthRepository.accounts)
              ListTile(
                dense: true,
                enabled: enabled,
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                leading: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.navy,
                  foregroundColor: Colors.white,
                  child: Text(a.user.initials, style: const TextStyle(fontSize: 12)),
                ),
                title: Text(a.user.role.label(l10n)),
                subtitle: Text(a.user.email),
                trailing: const Icon(Icons.input),
                onTap: () => onSelect(a.user.email),
              ),
          ],
        ),
      ],
    );
  }
}
