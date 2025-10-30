
import 'dart:ui';
import 'package:flame/components.dart';



class Dash extends PositionComponent {
  Dash() : super(
    position: Vector2(0, 0), 
    size: Vector2.all(80),
    anchor: Anchor.center,
    priority: 10,
    );

    late Sprite _dashSprite;
    
    final Vector2 _gravity = Vector2(0, 1200.0);
    Vector2 _velcity = Vector2(0, 0);

    final Vector2 _jumbForce =Vector2(0, -500);

    @override
  Future<void> onLoad() async  {
    await super.onLoad();
    // debugMode = true;
    _dashSprite = await Sprite.load("dash.png");
  }


  @override
  void update(double dt) {
    super.update(dt);
    // position += Vector2(0,0);
    // position.x += 0.2; 

    _velcity += _gravity * dt;
    position +=_velcity * dt ;

  }

  void jump(){
    _velcity = _jumbForce;
  }

  @override
  void render(Canvas canvas) {

    super.render(canvas);
  
    _dashSprite.render(canvas, size: size);

    // canvas.drawRect(
    //   Rect.fromCenter(center: Offset(10, 40), width: size.x, height: size.y), 
    //   BasicPalette.red.paint(),
    //   );
  }
}
