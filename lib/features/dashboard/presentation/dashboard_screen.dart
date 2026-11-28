import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../core/utils/l10n_extensions.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/notice_banner.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../models/app_user.dart';
import '../../../models/dashboard_snapshot.dart';
import '../../../models/verification_status.dart';
import '../../authentication/application/auth_providers.dart';
import '../application/dashboard_providers.dart';
import 'widgets/activity_tile.dart';
import 'widgets/module_tile.dart';
import 'widgets/stat_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref.watch(currentUserProvider);
    final snapshot = ref.watch(dashboardSnapshotProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: Row(
          children: [
            const AppLogo(size: 34),
            const SizedBox(width: 10),
            Flexible(child: Text(l10n.dashboardTitle, overflow: TextOverflow.ellipsis)),
          ],
        ),
        actions: [
          IconButton(
            key: const Key('dashboard.settings'),
            tooltip: l10n.settingsTitle,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(dashboardSnapshotProvider.future),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final statColumns = width >= 1000 ? 5 : (width >= 640 ? 3 : 2);
            final moduleColumns = width >= 1000 ? 7 : (width >= 640 ? 4 : 3);
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                if (user != null) _HeaderCard(user: user),
                const SizedBox(height: 14),
                NoticeBanner(kind: NoticeKind.danger, message: l10n.hseWarning),
                const SizedBox(height: 14),
                ...snapshot.when(
                  data: (data) => _content(context, data, statColumns, moduleColumns),
                  loading: () => const [
                    Padding(
                      padding: EdgeInsets.all(48),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ],
                  error: (_, _) => [
                    NoticeBanner(kind: NoticeKind.danger, message: l10n.loadError),
                    TextButton(
                      onPressed: () => ref.invalidate(dashboardSnapshotProvider),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _content(
    BuildContext context,
    DashboardSnapshot data,
    int statColumns,
    int moduleColumns,
  ) {
    final l10n = context.l10n;
    final s = data.stats;
    return [
      if (data.containsDemoData) ...[
        NoticeBanner(kind: NoticeKind.demo, message: l10n.demoDataBanner),
        const SizedBox(height: 14),
      ],
      _SectionTitle(
        l10n.keyIndicators,
        trailing: data.containsDemoData ? DemoBadge(label: l10n.demoBadge) : null,
      ),
      GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: statColumns,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          // Fixed height so 2-line labels + hint fit on narrow phones.
          mainAxisExtent: 160,
        ),
        children: [
          StatCard(
            label: l10n.statInspections,
            value: s.totalInspections,
            icon: Icons.fact_check_outlined,
            color: AppColors.documentedBlue,
          ),
          StatCard(
            label: l10n.statScanSessions,
            value: s.totalScanSessions,
            icon: Icons.photo_camera_outlined,
            color: AppColors.green,
          ),
          StatCard(
            label: l10n.statSuspectedLocations,
            value: s.suspectedLocations,
            icon: Icons.help_outline,
            color: AppColors.orange,
            hint: l10n.statSuspectedHint,
          ),
          StatCard(
            label: l10n.statVerifiedNetworks,
            value: s.verifiedNetworks,
            icon: Icons.verified_outlined,
            color: AppColors.green,
            hint: l10n.statVerifiedHint,
          ),
          StatCard(
            label: l10n.statOpenRiskZones,
            value: s.openRiskZones,
            icon: Icons.dangerous_outlined,
            color: AppColors.red,
          ),
        ],
      ),
      const SizedBox(height: 22),
      _SectionTitle(l10n.evidenceLevels),
      const _EvidenceLegend(),
      const SizedBox(height: 22),
      _SectionTitle(l10n.modules),
      GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: moduleColumns,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 136,
        ),
        children: [
          ModuleTile(label: l10n.moduleScanner, icon: Icons.document_scanner_outlined, plannedPhase: 3),
          ModuleTile(label: l10n.moduleAiAnalysis, icon: Icons.auto_awesome_outlined, plannedPhase: 4),
          ModuleTile(label: l10n.moduleNetworkMap, icon: Icons.map_outlined, plannedPhase: 5),
          ModuleTile(label: l10n.moduleAr, icon: Icons.view_in_ar_outlined, plannedPhase: 6),
          ModuleTile(label: l10n.moduleHse, icon: Icons.health_and_safety_outlined, plannedPhase: 6),
          ModuleTile(label: l10n.moduleHistory, icon: Icons.history, plannedPhase: 3),
          ModuleTile(label: l10n.moduleReports, icon: Icons.picture_as_pdf_outlined, plannedPhase: 7),
        ],
      ),
      const SizedBox(height: 22),
      _SectionTitle(l10n.recentActivities),
      Card(
        child: data.recentActivities.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: Column(
                  children: [
                    Icon(Icons.inbox_outlined,
                        size: 40,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4)),
                    const SizedBox(height: 10),
                    Text(l10n.noActivities, style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(l10n.noActivitiesHint,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              )
            : Column(
                children: [
                  for (final (i, e) in data.recentActivities.indexed) ...[
                    if (i > 0) const Divider(indent: 16, endIndent: 16),
                    ActivityTile(entry: e),
                  ],
                ],
              ),
      ),
    ];
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radius),
        gradient: const LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [AppColors.navy, AppColors.navyLight],
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.green,
            foregroundColor: Colors.white,
            child: Text(user.initials, style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.greeting(user.displayName),
                  style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.dashboardSubtitle,
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    Pill(label: user.role.label(l10n), color: AppColors.green, icon: Icons.badge_outlined),
                    if (user.isDemo) DemoBadge(label: l10n.demoBadge),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EvidenceLegend extends StatelessWidget {
  const _EvidenceLegend();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.evidenceLevelsHint, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in VerificationStatus.values)
                  Pill(label: s.label(l10n), color: s.color, icon: s.icon),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, {this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(child: Text(text, style: Theme.of(context).textTheme.titleMedium)),
          ?trailing,
        ],
      ),
    );
  }
}
