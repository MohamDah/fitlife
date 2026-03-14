import 'package:flutter/material.dart';

/// Google-branded sign-in button that matches Google's branding guidelines.
/// Purely presentational — calls [onPressed] when tapped.
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: isDark ? const Color(0xFF2C2C2C) : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black87,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(
          color: isDark ? const Color(0xFF455A64) : const Color(0xFFDDDDDD),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _GoogleLogo(),
          const SizedBox(width: 12),
          const Text(
            'Continue with Google',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

/// Draws the Google "G" using four coloured arcs — no image asset required.
class _GoogleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeW = 3.0;
    final rect = Rect.fromCircle(center: center, radius: radius);

    void arc(double start, double sweep, Color color) {
      canvas.drawArc(
        rect,
        start,
        sweep,
        false,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeW
          ..strokeCap = StrokeCap.round,
      );
    }

    const pi = 3.14159265;
    arc(-0.3, pi * 0.6, const Color(0xFF4285F4)); // blue
    arc(pi * 0.3, pi * 0.5, const Color(0xFFEA4335)); // red
    arc(pi * 0.8, pi * 0.6, const Color(0xFFFBBC05)); // yellow
    arc(pi * 1.4, pi * 0.6, const Color(0xFF34A853)); // green

    final barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(center.dx, center.dy),
      Offset(center.dx + radius * 0.9, center.dy),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
