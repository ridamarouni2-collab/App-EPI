import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../app/theme.dart';

/// Vector logo: a concrete slab with a buried pipe and scan waves.
/// Drawn in code so it stays sharp at any size and needs no asset.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 72, this.scanProgress});

  final double size;

  /// Optional 0..1 animation value for the scan waves (splash screen).
  final double? scanProgress;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'UNDERGROUND SCAN AI',
      image: true,
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(painter: _LogoPainter(scanProgress)),
      ),
    );
  }
}

class _LogoPainter extends CustomPainter {
  _LogoPainter(this.progress);

  final double? progress;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final rect = Offset.zero & size;

    // Badge background.
    final bg = RRect.fromRectAndRadius(rect, Radius.circular(s * 0.24));
    canvas.drawRRect(
      bg,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navyLight, AppColors.navy],
        ).createShader(rect),
    );

    // Concrete floor line.
    final floorY = s * 0.42;
    canvas.drawLine(
      Offset(s * 0.14, floorY),
      Offset(s * 0.86, floorY),
      Paint()
        ..color = const Color(0xFFB9C4CF)
        ..strokeWidth = s * 0.05
        ..strokeCap = StrokeCap.round,
    );
    // Concrete hatching.
    final hatch = Paint()
      ..color = const Color(0x55B9C4CF)
      ..strokeWidth = s * 0.018;
    for (var i = 0; i < 6; i++) {
      final x = s * (0.2 + i * 0.11);
      canvas.drawLine(Offset(x, floorY + s * 0.05), Offset(x - s * 0.05, floorY + s * 0.12), hatch);
    }

    // Buried pipe (dashed orange = estimated route).
    final pipeY = s * 0.72;
    final pipe = Paint()
      ..color = AppColors.orange
      ..strokeWidth = s * 0.07
      ..strokeCap = StrokeCap.round;
    const dashes = 4;
    for (var i = 0; i < dashes; i++) {
      final x0 = s * (0.14 + i * 0.19);
      canvas.drawLine(Offset(x0, pipeY), Offset(x0 + s * 0.11, pipeY), pipe);
    }

    // Scan waves (green), emitted from a phone point above the floor.
    final center = Offset(s * 0.5, floorY - s * 0.06);
    final p = progress;
    for (var i = 0; i < 3; i++) {
      final phase = p == null ? 1.0 : ((p + i / 3) % 1.0);
      final radius = s * (0.08 + 0.11 * (p == null ? (i + 1) / 1.4 : phase * 2.2));
      final opacity = p == null ? 0.9 - i * 0.25 : (1 - phase).clamp(0.0, 1.0);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi * 0.85,
        math.pi * 0.7,
        false,
        Paint()
          ..color = AppColors.green.withValues(alpha: opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = s * 0.04
          ..strokeCap = StrokeCap.round,
      );
    }
    canvas.drawCircle(center, s * 0.045, Paint()..color = AppColors.green);
  }

  @override
  bool shouldRepaint(_LogoPainter old) => old.progress != progress;
}
