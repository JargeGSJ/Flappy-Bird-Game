

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash_game/bloc/game/game_cubit.dart';
import 'package:flappy_dash_game/components/hidden_coin.dart' show HiddenCoin;
import 'package:flappy_dash_game/components/pipe.dart' show Pipe;



class PipePair extends PositionComponent with FlameBlocReader<GameCubit, GameState>{

  PipePair({
    required super.position,
    this.gap = 200.0,
    
  });

  final double gap;
  final speed =200;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // debugMode = true;

    addAll(
      [
        Pipe(
          isFlipped: false, 
          position: Vector2(0, gap/2)
        ),
        Pipe(
          isFlipped: true, 
          position: Vector2(0, -gap/2)
        ),
        HiddenCoin(
          position: Vector2(0, 0)
        ),
      ]
    );
  }

  @override
  void update(double dt) {
    switch(bloc.state.currentPlayingState){

      case PlayingState.none:
      case PlayingState.paused:
      case PlayingState.gameOver:
        break;
      case PlayingState.playing:
    position.x -= speed * dt;
    break;
    }

    super.update(dt);
  }

}