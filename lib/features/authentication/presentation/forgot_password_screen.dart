import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/routes.dart';
import '../../../core/utils/l10n_extensions.dart';
import '../../../core/widgets/notice_banner.dart';
import '../../../repositories/auth_repository.dart';
import '../application/auth_providers.dart';
import 'auth_form_helpers.dart';
import 'auth_scaffold.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key, this.initialEmail});

  final String? initialEmail;

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _email = TextEditingController(text: widget.initialEmail);
  bool _loading = false;
  AuthErrorCode? _error;
  String? _sentTo;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
      _sentTo = null;
    });
    final email = _email.text.trim();
    try {
      await ref.read(authRepositoryProvider).sendPasswordResetEmail(email);
      if (mounted) setState(() => _sentTo = email);
    } on AuthException catch (e) {
      if (mounted) setState(() => _error = e.code);
    } catch (_) {
      if (mounted) setState(() => _error = AuthErrorCode.unknown);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return AuthScaffold(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.forgotPasswordTitle, style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(l10n.forgotPasswordBody, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 20),
            TextFormField(
              key: const Key('reset.email'),
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              enabled: !_loading,
              onFieldSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: l10n.emailLabel,
                prefixIcon: const Icon(Icons.alternate_email),
              ),
              validator: (v) => emailErrorText(l10n, v),
            ),
            const SizedBox(height: 16),
            if (_error != null) ...[
              NoticeBanner(kind: NoticeKind.danger, message: _error!.message(l10n)),
              const SizedBox(height: 14),
            ],
            if (_sentTo != null) ...[
              NoticeBanner(kind: NoticeKind.info, message: l10n.resetLinkSent(_sentTo!)),
              const SizedBox(height: 14),
            ],
            FilledButton(
              key: const Key('reset.submit'),
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const SizedBox.square(
                      dimension: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                    )
                  : Text(l10n.sendResetLink),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _back,
              icon: const Icon(Icons.arrow_back),
              label: Text(l10n.backToLogin),
            ),
          ],
        ),
      ),
    );
  }
}
