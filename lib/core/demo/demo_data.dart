import '../../models/dashboard_snapshot.dart';

/// DEMO DATA — fictitious values used only to present the interface when the
/// user explicitly enables "Demo data" in settings. Every item is flagged
/// `isDemo` and the UI shows a DEMO banner/badge. These numbers do not come
/// from any detection, inspection or site.
abstract final class DemoData {
  static const siteName = 'Site DÉMO – Atelier A';

  static const stats = DashboardStats(
    totalInspections: 12,
    totalScanSessions: 27,
    suspectedLocations: 9,
    verifiedNetworks: 3,
    openRiskZones: 4,
  );

  static List<ActivityEntry> activities(DateTime now) => [
        ActivityEntry(
          id: 'demo-act-1',
          type: ActivityType.scanSession,
          reference: 'DEMO-SCAN-0027',
          siteName: siteName,
          actorName: 'Inspecteur Démo',
          timestamp: now.subtract(const Duration(minutes: 42)),
          isDemo: true,
        ),
        ActivityEntry(
          id: 'demo-act-2',
          type: ActivityType.riskZone,
          reference: 'DEMO-RZ-004',
          siteName: siteName,
          actorName: 'Responsable HSE Démo',
          timestamp: now.subtract(const Duration(hours: 3, minutes: 10)),
          isDemo: true,
        ),
        ActivityEntry(
          id: 'demo-act-3',
          type: ActivityType.network,
          reference: 'DEMO-NET-PEHD-02',
          siteName: siteName,
          actorName: 'Technicien Démo',
          timestamp: now.subtract(const Duration(days: 1, hours: 2)),
          isDemo: true,
        ),
        ActivityEntry(
          id: 'demo-act-4',
          type: ActivityType.inspection,
          reference: 'DEMO-INS-0012',
          siteName: siteName,
          actorName: 'Inspecteur Démo',
          timestamp: now.subtract(const Duration(days: 2, hours: 5)),
          isDemo: true,
        ),
      ];
}
