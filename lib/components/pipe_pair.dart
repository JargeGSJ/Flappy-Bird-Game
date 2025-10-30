

import 'package:flame/components.dart';
import 'package:flappy_dash_game/components/pipe.dart' show Pipe;


class PipePair extends PositionComponent{

  PipePair({
    required super.position,
    this.gap = 200.0,
    
  });

  final double gap;
  final speed =150;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    addAll(
      [
        Pipe(
          isFlipped: false, 
          position: Vector2(0, gap/2)
        ),
        Pipe(
          isFlipped: true, 
          position: Vector2(0, -gap/2)
        )
      ]
    );
  }

  @override
  void update(double dt) {
    position.x -= speed * dt;
    super.update(dt);
  }

}