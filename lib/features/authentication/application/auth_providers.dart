import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/preferences_service.dart';
import '../../../models/app_user.dart';
import '../../../repositories/auth_repository.dart';
import '../../../repositories/local_demo_auth_repository.dart';

/// Active authentication backend. Phase 2 swaps in the Firebase implementation.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final repo = LocalDemoAuthRepository(ref.watch(preferencesServiceProvider));
  ref.onDispose(repo.dispose);
  return repo;
});

/// The signed-in user, kept in sync with the repository.
final currentUserProvider = NotifierProvider<CurrentUserNotifier, AppUser?>(
  CurrentUserNotifier.new,
);

class CurrentUserNotifier extends Notifier<AppUser?> {
  @override
  AppUser? build() {
    final repo = ref.watch(authRepositoryProvider);
    void sync() => state = repo.currentUser;
    repo.addListener(sync);
    ref.onDispose(() => repo.removeListener(sync));
    return repo.currentUser;
  }
}
