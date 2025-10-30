
// import 'package:flame/components.dart';
// import 'package:flame/events.dart';
// import 'package:flame/game.dart';
// import 'package:flappy_dash_game/components/dash.dart' show Dash;
// import 'package:flappy_dash_game/components/dash_parallax_background.dart' show DashBackground;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';



// class FlappyDashGame extends FlameGame<FlappyDeshWorld> with KeyboardEvents  {
//   FlappyDashGame()
//     : super(
//         world: FlappyDeshWorld(),
//         camera: CameraComponent.withFixedResolution(width: 600, height: 1000),
//       );

//   @override
//   void onGameResize(Vector2 size) {
//     super.onGameResize(size);
//     print('onGameResive($size)');
//   }


//   @override
//   KeyEventResult onKeyEvent(
//       KeyEvent event,
//       Set<LogicalKeyboardKey> keysPressed,
//       ) {
//     final isKeyDown = event is KeyDownEvent;

//     final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

//     if (isSpace && isKeyDown) {
//       world.onSpaceDown();
//       return KeyEventResult.handled;
//     }
//     return KeyEventResult.ignored;
//   }
// }


// class FlappyDeshWorld extends World with TapCallbacks{

//   late Dash _dash;
//   @override
//   void onLoad() {
//     super.onLoad();
//     add(DashBackground());
//     add(_dash = Dash());
//   }

//  @override
//   void onTapDown(TapDownEvent event) {
//     super.onTapDown(event);
//     _dash.jump();
//   }

//   void onSpaceDown() {
//     _dash.jump();
//   }

// }



import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash_game/audio_helper.dart';
import 'package:flappy_dash_game/bloc/game/game_cubit.dart';
import 'package:flappy_dash_game/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:flappy_dash_game/components/dash.dart' show Dash;
import 'package:flappy_dash_game/components/dash_parallax_background.dart' show DashParallaxBackground;
import 'package:flappy_dash_game/components/pipe_pair.dart' show PipePair;




class FlappyDashGame extends FlameGame<FlappyDashWorld> with KeyboardEvents,  HasCollisionDetection {
  FlappyDashGame(this.gameCubit)
      : super(
          world: FlappyDashWorld(),
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 1100,
          ),
        );

        final GameCubit gameCubit;

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
}

class FlappyDashWorld extends World with TapCallbacks, HasGameReference<FlappyDashGame> {
  
  late FlappyDashRootCompoent _rootCompoent;

  @override
  Future<void> onLoad() async{
     super.onLoad();
      await getIt.get<AudioHelper>().initialize();
     add(
      FlameBlocProvider<GameCubit, GameState>
      (create: () => game.gameCubit,
        children: [
        _rootCompoent = FlappyDashRootCompoent()
        ],
      ),
     );
  }

  void onSpaceDown() => _rootCompoent.onSpaceDown();

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    _rootCompoent.onTapDown(event);

  }
}

class FlappyDashRootCompoent extends Component with HasGameReference<FlappyDashGame>,FlameBlocReader<GameCubit, GameState>{
  late Dash _dash;
  late PipePair _lastPipe;
  static final _pipeDistance = 400.0;
  // late int _score = 0;
  // late TextComponent _scoreText;

  
  @override
  Future<void> onLoad() async {
   await super.onLoad();
    add(DashParallaxBackground());
    add(_dash = Dash()); 

    _generatePipe(
      fromX: 350
    );

    // game.camera.viewfinder.add(
    //   _scoreText = TextComponent(
    //   // text: _score.toString(),
    //   position: Vector2(0, -(game.size.y /2)),
    // ));

  }

  void _generatePipe(
    {
      int count = 5, 
      double fromX = 0.0, 
    }
  ){
    for(int i= 0; i < count; i++){
      const area = 600;
      final y = (Random().nextDouble() * area )- (area / 2);
      add(_lastPipe = PipePair(position: Vector2(fromX + (i * _pipeDistance), y)));
    }
  }

  void _removePipe(){
    final pipes = children.whereType<PipePair>();
    final shouldBeRmovedPipe = max(pipes.length - 5,0);

    pipes.take(shouldBeRmovedPipe).forEach((pipe){
      pipe.removeFromParent();
    });

    // pipes.take(shouldBeRmovedPipe as int).forEach((pipe){
    //   pipe.removeFromParent();
    // });
  }


  // @override
  // void onTapDown(TapDownEvent event) {
  //   super.onTapDown(event);
  //   _dash.jump();
  // }


  void onSpaceDown() {
    _checkStart();
    // super.onTapDown(event);
    _dash.jump();
  }

  void onTapDown(TapDownEvent event) {
    _checkStart();
    _dash.jump();
  }

  // void increaseScore(){
  //   _score += 1;
  // }

  void _checkStart(){
    if(bloc.state.currentPlayingState.isIdle){
      bloc.startPlaying();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

  // _scoreText.text =  bloc.state.currentScore.toString();   
    if(_dash.x >= _lastPipe.x){
      _generatePipe(
        fromX: _pipeDistance
      );
      _removePipe();
    }
    game.camera.viewfinder.zoom =1.0;
  }
  

}

