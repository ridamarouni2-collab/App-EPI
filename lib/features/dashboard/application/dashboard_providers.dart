import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/dashboard_snapshot.dart';
import '../../../repositories/dashboard_repository.dart';
import '../../settings/application/settings_controller.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => const LocalDashboardRepository(),
);

final dashboardSnapshotProvider = FutureProvider<DashboardSnapshot>((ref) {
  final includeDemo =
      ref.watch(settingsControllerProvider.select((s) => s.showDemoData));
  return ref
      .watch(dashboardRepositoryProvider)
      .loadSnapshot(includeDemoData: includeDemo);
});
