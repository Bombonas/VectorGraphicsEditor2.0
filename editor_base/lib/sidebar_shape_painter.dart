import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'layout_design_painter.dart';
import 'util_shape.dart';

class SidebarShapePainter extends CustomPainter {
  final Shape shape;

  SidebarShapePainter(this.shape);

  @override
  void paint(Canvas canvas, Size size) {
    // Defineix els límits de dibuix del canvas
    Rect visibleRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(visibleRect);

    // Calcula les dimensions màximes del polígon
    double minX = double.infinity, minY = double.infinity;
    double maxX = -double.infinity, maxY = -double.infinity;
    for (final vertex in shape.vertices) {
      double vertexX = shape.position.dx + vertex.dx;
      double vertexY = shape.position.dy + vertex.dy;
      minX = math.min(minX, vertexX);
      minY = math.min(minY, vertexY);
      maxX = math.max(maxX, vertexX);
      maxY = math.max(maxY, vertexY);
    }

    // Dimensions màximes del polígon
    double width = maxX - minX;
    double height = maxY - minY;
    // Centre del polígon
    double centerX = minX + width / 2;
    double centerY = minY + height / 2;

    // Escala per ajustar el polígon dins del canvas
    double scaleX = size.width / width;
    double scaleY = size.height / height;
    double scale = math.min(scaleX, scaleY);

    // Centre del canvas
    double canvasCenterX = size.width / 2;
    double canvasCenterY = size.height / 2;

    double tX = canvasCenterX - centerX * scale;
    double tY = canvasCenterY - centerY * scale;

    canvas.translate(tX, tY);
    canvas.scale(scale);

    // Dibuixa el polígon
    LayoutDesignPainter.paintShape(canvas, shape, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
