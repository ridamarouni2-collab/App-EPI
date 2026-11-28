import 'package:material_ui/material_ui.dart';

import '../../app/theme.dart';

enum NoticeKind { danger, demo, info }

/// Full-width colored notice used for HSE warnings and demo-data notices.
class NoticeBanner extends StatelessWidget {
  const NoticeBanner({super.key, required this.kind, required this.message, this.title});

  final NoticeKind kind;
  final String message;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final (color, icon) = switch (kind) {
      NoticeKind.danger => (AppColors.red, Icons.warning_amber_rounded),
      NoticeKind.demo => (AppColors.orange, Icons.science_outlined),
      NoticeKind.info => (AppColors.documentedBlue, Icons.info_outline),
    };
    final theme = Theme.of(context);
    return Semantics(
      container: true,
      liveRegion: kind == NoticeKind.danger,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: theme.brightness == Brightness.dark ? 0.18 : 0.10),
          borderRadius: BorderRadius.circular(AppTheme.radius),
          border: BorderDirectional(start: BorderSide(color: color, width: 5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(title!,
                          style: theme.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700)),
                    ),
                  Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: kind == NoticeKind.danger ? FontWeight.w700 : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
