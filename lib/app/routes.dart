import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/application/auth_providers.dart';
import '../features/authentication/presentation/forgot_password_screen.dart';
import '../features/authentication/presentation/login_screen.dart';
import '../features/authentication/presentation/splash_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/settings/presentation/settings_screen.dart';

abstract final class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const dashboard = '/dashboard';
  static const settings = '/settings';

  static const _public = {splash, login, forgotPassword};
}

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authRepositoryProvider);
  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: auth,
    redirect: (context, state) {
      final loggedIn = auth.currentUser != null;
      final location = state.matchedLocation;
      // The splash screen decides where to go once bootstrapping completes.
      if (location == AppRoutes.splash) return null;
      if (!loggedIn && !AppRoutes._public.contains(location)) {
        return AppRoutes.login;
      }
      if (loggedIn && (location == AppRoutes.login || location == AppRoutes.forgotPassword)) {
        return AppRoutes.dashboard;
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', redirect: (_, _) => AppRoutes.dashboard),
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, state) =>
            ForgotPasswordScreen(initialEmail: state.uri.queryParameters['email']),
      ),
      GoRoute(path: AppRoutes.dashboard, builder: (_, _) => const DashboardScreen()),
      GoRoute(path: AppRoutes.settings, builder: (_, _) => const SettingsScreen()),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
