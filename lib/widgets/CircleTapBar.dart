import 'package:flutter/material.dart';
//credits https://www.youtube.com/watch?v=x4DydJKVvQk
class CircleTabIndicator extends Decoration{
  late final Color color;
  late final double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }

}

class _CirclePainter extends BoxPainter{
  late final Color color;
  late double radius;
  _CirclePainter({required this.color, required this.radius});


  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color= color;
    _paint.isAntiAlias= true;
    final Offset circleOffset = Offset(configuration.size!.width/2 -radius/2, configuration.size!.height - radius);
    canvas.drawCircle(offset+circleOffset, radius, _paint);
  }

}