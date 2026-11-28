import '../core/demo/demo_data.dart';
import '../models/dashboard_snapshot.dart';

/// Source of dashboard indicators.
///
/// Phase 1: no inspection data exists yet, so the local implementation
/// returns real (empty) values, optionally merged with clearly-labelled demo
/// data. Phase 2 replaces it with Firestore aggregations.
abstract class DashboardRepository {
  Future<DashboardSnapshot> loadSnapshot({required bool includeDemoData});
}

class LocalDashboardRepository implements DashboardRepository {
  const LocalDashboardRepository();

  @override
  Future<DashboardSnapshot> loadSnapshot({required bool includeDemoData}) async {
    if (!includeDemoData) {
      return const DashboardSnapshot(
        stats: DashboardStats.empty,
        recentActivities: [],
        containsDemoData: false,
      );
    }
    final now = DateTime.now();
    return DashboardSnapshot(
      stats: DemoData.stats,
      recentActivities: DemoData.activities(now),
      containsDemoData: true,
    );
  }
}
