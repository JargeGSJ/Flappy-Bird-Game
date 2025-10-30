
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
// import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash_game/bloc/game/game_cubit.dart';
import 'package:flappy_dash_game/components/hidden_coin.dart';
import 'package:flappy_dash_game/components/pipe.dart';
import 'package:flappy_dash_game/flappy_dash_game.dart';
import 'package:flutter/widgets.dart';



class Dash extends PositionComponent with CollisionCallbacks, HasGameReference<FlappyDashGame>, FlameBlocReader<GameCubit , GameState>{
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
    _dashSprite = await Sprite.load("dash.png");
    // debugMode = true;
    final radius = size.x /2;
    final center = size /2 ;
    add(CircleHitbox(
      radius: radius * 0.75,
      position :center * 1.1,
      anchor: Anchor.center
    ));
  }


  @override
  void update(double dt) {
    super.update(dt);
    // position += Vector2(0,0);
    // position.x += 0.2; 

    if(bloc.state.currentPlayingState.isNotPlaying){
      return;
    }

    _velcity += _gravity * dt;
    position +=_velcity * dt ;

  }

  void jump(){

    if(bloc.state.currentPlayingState.isNotPlaying){
      return;
    }
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


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
   super.onCollision(intersectionPoints, other);
   print('coint testing');

  if(bloc.state.currentPlayingState.isNotPlaying){
    return;
  }

   if(other is HiddenCoin){
    print("increate the coin");
    bloc.increaseScore();
    // game.world.increaseScore();
    other.removeFromParent();
   }else if(other is Pipe){
    bloc.gameOver();
    print("game overs");
   }
  }
}
