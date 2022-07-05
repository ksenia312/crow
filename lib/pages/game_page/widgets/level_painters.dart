import 'package:flutter/material.dart';

class FirstStepWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.lightBlue
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.6,
        size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.8,
        size.width * 1.0, size.height * 0.6);
    path.lineTo(size.width, size.height);

    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SecondStepWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.lightBlue
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ThirdStepWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.lightBlue
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.9,
        size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.6);
    path.lineTo(size.width, size.height);

    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Level4PassButtonPainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final int part;

  Level4PassButtonPainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke,
      this.part = 0});

  List paths(double x, double y) => [
        Path()
          ..moveTo(0, y)
          ..lineTo(0, 0)
          ..lineTo(x / 3, y)
          ..lineTo(0, y),
        Path()
          ..moveTo(0, 0)
          ..lineTo(x / 3, 0)
          ..lineTo(x / 3, y)
          ..lineTo(0, 0),
        Path()
          ..moveTo(x / 3, y)
          ..lineTo(x / 3, 0)
          ..lineTo(2 * x / 3, y)
          ..lineTo(x / 3, y),
        Path()
          ..moveTo(x / 3, 0)
          ..lineTo(2 * x / 3, 0)
          ..lineTo(2 * x / 3, y)
          ..lineTo(x / 3, 0),
        Path()
          ..moveTo(2 * x / 3, y)
          ..lineTo(2 * x / 3, 0)
          ..lineTo(x, y)
          ..lineTo(2 * x / 3, y),
        Path()
          ..moveTo(2 * x / 3, 0)
          ..lineTo(x, 0)
          ..lineTo(x, y)
          ..lineTo(2 * x / 3, 0),
      ];

  Path getTrianglePath(double x, double y, part) {
    return paths(x, y)[part];
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(paths(size.width, size.height)[part], paint);
  }

  @override
  bool shouldRepaint(Level4PassButtonPainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class GlassPainter extends CustomPainter {
  final Color strokeColor;

  GlassPainter({required this.strokeColor});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = strokeColor
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.3);
    path.lineTo(size.width * 0.02, size.height * 0.6);
    path.lineTo(size.width * 0.04, size.height * 0.85);
    path.lineTo(size.width * 0.06, size.height * 0.6);
    path.lineTo(size.width * 0.08, size.height * 0.9);
    path.lineTo(size.width * 0.10, size.height * 0.5);
    path.lineTo(size.width * 0.12, size.height * 0.95);
    path.lineTo(size.width * 0.14, size.height * 0.3);
    path.lineTo(size.width * 0.16, size.height * 0.9);
    path.lineTo(size.width * 0.18, size.height * 0.5);
    path.lineTo(size.width * 0.20, size.height * 0.85);
    path.lineTo(size.width * 0.22, size.height * 0.6);
    path.lineTo(size.width * 0.24, size.height * 0.8);
    path.lineTo(size.width * 0.26, size.height * 0.3);
    path.lineTo(size.width * 0.28, size.height * 0.9);
    path.lineTo(size.width * 0.30, size.height * 0.6);
    path.lineTo(size.width * 0.32, size.height * 0.85);
    path.lineTo(size.width * 0.34, size.height * 0.5);
    path.lineTo(size.width * 0.36, size.height * 0.85);
    path.lineTo(size.width * 0.38, size.height * 0.6);
    path.lineTo(size.width * 0.40, size.height * 0.85);
    path.lineTo(size.width * 0.42, size.height * 0.6);
    path.lineTo(size.width * 0.44, size.height * 0.85);
    path.lineTo(size.width * 0.46, size.height * 0.5);
    path.lineTo(size.width * 0.49, size.height * 0.85);
    path.lineTo(size.width * 0.51, size.height * 0.6);
    path.lineTo(size.width * 0.53, size.height * 0.9);
    path.lineTo(size.width * 0.54, size.height * 0.6);
    path.lineTo(size.width * 0.56, size.height * 0.85);
    path.lineTo(size.width * 0.58, size.height * 0.4);
    path.lineTo(size.width * 0.60, size.height * 0.85);
    path.lineTo(size.width * 0.62, size.height * 0.6);
    path.lineTo(size.width * 0.64, size.height * 0.85);
    path.lineTo(size.width * 0.66, size.height * 0.65);
    path.lineTo(size.width * 0.67, size.height * 0.9);
    path.lineTo(size.width * 0.69, size.height * 0.65);
    path.lineTo(size.width * 0.71, size.height * 0.9);
    path.lineTo(size.width * 0.73, size.height * 0.3);
    path.lineTo(size.width * 0.75, size.height * 0.9);
    path.lineTo(size.width * 0.77, size.height * 0.4);
    path.lineTo(size.width * 0.79, size.height * 0.85);
    path.lineTo(size.width * 0.81, size.height * 0.5);
    path.lineTo(size.width * 0.83, size.height * 0.9);
    path.lineTo(size.width * 0.85, size.height * 0.35);
    path.lineTo(size.width * 0.87, size.height * 0.7);
    path.lineTo(size.width * 0.89, size.height * 0.3);
    path.lineTo(size.width * 0.91, size.height * 0.95);
    path.lineTo(size.width * 0.93, size.height * 0.4);
    path.lineTo(size.width * 0.95, size.height * 0.9);
    path.lineTo(size.width * 0.97, size.height * 0.2);
    path.lineTo(size.width * 0.99, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
