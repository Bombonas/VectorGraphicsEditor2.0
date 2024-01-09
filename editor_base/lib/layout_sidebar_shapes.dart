import 'package:editor_base/app_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'util_shape.dart';
import 'sidebar_shape_painter.dart';

class LayoutSidebarShapes extends StatelessWidget {
  const LayoutSidebarShapes({super.key});

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    return SizedBox(
      width: double.infinity, // Estira el widget horitzontalment
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            const Text('List of shapes'),
            const SizedBox(height: 8),
            ...appData.shapesList.map((shape) {
              return Container(
                  child: Row(children: [
                Text("Shape ${appData.shapesList.indexOf(shape) + 1}"),
                const SizedBox(width: 98),
                CustomPaint(
                  painter: SidebarShapePainter(shape),
                  size: const Size(48, 48),
                ),
              ]));
            }).toList(),
          ],
        ),
      ),
    );
  }
}
