
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash_game/components/dash.dart' show Dash;
import 'package:flappy_dash_game/components/dash_parallax_background.dart' show DashParallaxBackground;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class FlappyDashGame extends FlameGame<FlappyDeshWorld> with KeyboardEvents  {
  FlappyDashGame()
    : super(
        world: FlappyDeshWorld(),
        camera: CameraComponent.withFixedResolution(width: 600, height: 1000),
      );

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    print('onGameResive($size)');
  }


  @override
  KeyEventResult onKeyEvent(
      KeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,
      ) {
    final isKeyDown = event is KeyDownEvent;

    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSpace && isKeyDown) {
      world.onSpaceDown();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }



  // @override
  // Future<void> onLoad() async {
  //   super.onLoad();

  //   print("onLoad()");
  // }

  // void onLoad(){
  //   super.onLoad();

  // add(Dash());
  // }

  // @override
  // void onMount() {
  //   super.onMount();
  //   print('onMount()');
  // }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   print('update($dt)');
  // }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   print('render()');
  // }
}


class FlappyDeshWorld extends World with TapCallbacks{

  late Dash _dash;


  @override
  void onLoad() {
    super.onLoad();
    add(DashParallaxBackground());
    add(_dash = Dash());

// ===========================
    // add(  
    //   // RectangleComponent(
    //   //   position: Vector2(10.0, 15.0),
    //   //   size: Vector2.all(50),
    //   //   angle: pi/2,
    //   //   anchor: Anchor.center,
    //   // ),
    //   // RectangleComponent.fromRect(
    //   //   Rect.fromLTWH(0, 0, 50, 50),
    //   // )

    // );
  
  
    // add( CircleComponent(radius: 50, position: Vector2.all(50), anchor: Anchor.center,));
    // add( CircleComponent(radius: 50, position: Vector2(-50,50), anchor: Anchor.center));
    // add( CircleComponent(radius: 50, position: Vector2(0,-20), anchor: Anchor.center));
    // add( CircleComponent(radius: 50, position: Vector2(0,-100), anchor: Anchor.center));
    // add( CircleComponent(radius: 50, position: Vector2(0,-180), anchor: Anchor.center));
  }

 @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    _dash.jump();
  }

  void onSpaceDown() {
    _dash.jump();
  }

}


// class Dash extends PositionComponent {
//   Dash() : super(
//     position: Vector2(0, -300), 
//     size: Vector2(40, 40)
//     );

//   @override
//   void update(double dt) {
//     super.update(dt);
//     // position.x += 0;
//     position.y -= 0.00;
//     angle += 2;
//   }

//   @override
//   void render(Canvas canvas) {

//     super.render(canvas);

//     canvas.drawRect(
//       Rect.fromCenter(center: Offset(10, 40), width: size.x, height: size.y), 
//       BasicPalette.red.paint(),
//       );
//     canvas.drawCircle(Offset(50, 100),40, BasicPalette.white.paint());
//     canvas.drawCircle(
//       Offset.zero, 
//       20, 
//       BasicPalette.white.paint()
//       );
//   }
// }
