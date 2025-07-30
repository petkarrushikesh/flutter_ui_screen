// widgets/chart_widget.dart
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  final List<double> data;
  final double height;
  final Color color;

  const ChartWidget({
    super.key,
    required this.data,
    required this.height,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: LineChartPainter(data, color),
        size: Size(double.infinity, height),
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;

  LineChartPainter(this.data, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final shadowPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final shadowPath = Path();
    final maxValue = data.reduce((a, b) => a > b ? a : b);
    final minValue = data.reduce((a, b) => a < b ? a : b);
    final range = maxValue - minValue;

    if (range == 0) return;

    // Create smooth curve points
    final points = <Offset>[];
    for (int i = 0; i < data.length; i++) {
      final x = (i / (data.length - 1)) * size.width;
      final y = size.height - ((data[i] - minValue) / range) * size.height;
      points.add(Offset(x, y));
    }

    if (points.isEmpty) return;

    // Create shadow area
    shadowPath.moveTo(0, size.height);
    shadowPath.lineTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      shadowPath.lineTo(points[i].dx, points[i].dy);
    }

    shadowPath.lineTo(size.width, size.height);
    shadowPath.close();
    canvas.drawPath(shadowPath, shadowPaint);

    // Create main line
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      // Create smooth curves using quadratic bezier
      final xMid = (points[i - 1].dx + points[i].dx) / 2;
      final yMid = (points[i - 1].dy + points[i].dy) / 2;
      final cpX1 = (xMid + points[i - 1].dx) / 2;
      final cpX2 = (xMid + points[i].dx) / 2;

      path.quadraticBezierTo(cpX1, points[i - 1].dy, xMid, yMid);
      path.quadraticBezierTo(cpX2, points[i].dy, points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);

    // Draw dots on data points
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final dotBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (final point in points) {
      // Draw white border
      canvas.drawCircle(point, 5, dotBorderPaint);
      // Draw colored dot
      canvas.drawCircle(point, 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}