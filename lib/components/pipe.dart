import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
// import 'package:flutter/material.dart';
import 'dart:ui';


class Pipe extends PositionComponent{

  late Sprite _pipeSprite;
  final bool isFlipped ;

Pipe({
  required this.isFlipped,
  required super.position
  }):super(priority: 2);


  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _pipeSprite = await Sprite.load("pipe.png");
    // position = Vector2(0, 0);
    late double ratio = _pipeSprite.srcSize.y / _pipeSprite.srcSize.x;
    anchor = Anchor.topCenter;
    const width = 82.0;
    size = Vector2(width, width * ratio);
    if(isFlipped){
      flipVertically();
    }

    add(RectangleHitbox());

  }


  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
    _pipeSprite.render(
      canvas, 
      position: Vector2.all(0),
      size: size,
    );
  }


}