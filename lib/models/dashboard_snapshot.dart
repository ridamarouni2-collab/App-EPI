/// Aggregated indicators displayed on the dashboard.
class DashboardStats {
  const DashboardStats({
    required this.totalInspections,
    required this.totalScanSessions,
    required this.suspectedLocations,
    required this.verifiedNetworks,
    required this.openRiskZones,
  });

  static const empty = DashboardStats(
    totalInspections: 0,
    totalScanSessions: 0,
    suspectedLocations: 0,
    verifiedNetworks: 0,
    openRiskZones: 0,
  );

  final int totalInspections;
  final int totalScanSessions;
  final int suspectedLocations;
  final int verifiedNetworks;
  final int openRiskZones;
}

enum ActivityType { inspection, scanSession, riskZone, network, report }

class ActivityEntry {
  const ActivityEntry({
    required this.id,
    required this.type,
    required this.reference,
    required this.siteName,
    required this.actorName,
    required this.timestamp,
    this.isDemo = false,
  });

  final String id;
  final ActivityType type;

  /// Business reference (e.g. inspection number, zone code).
  final String reference;
  final String siteName;
  final String actorName;
  final DateTime timestamp;
  final bool isDemo;
}

class DashboardSnapshot {
  const DashboardSnapshot({
    required this.stats,
    required this.recentActivities,
    required this.containsDemoData,
  });

  final DashboardStats stats;
  final List<ActivityEntry> recentActivities;
  final bool containsDemoData;
}
