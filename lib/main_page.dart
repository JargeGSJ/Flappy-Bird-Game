import 'package:flame/game.dart';
import 'package:flappy_dash_game/bloc/game/game_cubit.dart';
import 'package:flappy_dash_game/components/screens/game_over_widget.dart';
import 'package:flappy_dash_game/components/screens/tap_to_play.dart';
import 'package:flappy_dash_game/components/screens/top_score.dart';
import 'package:flappy_dash_game/flappy_dash_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late FlappyDashGame _flappyDashGame;
  late GameCubit gameCubit;

   PlayingState? _latestState;

  @override
  void initState() {
    gameCubit = BlocProvider.of<GameCubit>(context);
    _flappyDashGame =FlappyDashGame(gameCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(

      listener: (context, state) {
        if(state.currentPlayingState.isIdle && (_latestState?.isGameOver ?? false)){
          setState(() {
            _flappyDashGame = FlappyDashGame(gameCubit);
          });
        }
        _latestState = state.currentPlayingState;
      },
      
      builder: (context, state)
      {
        return Scaffold(
        // body: GameWidget(
        //   game: _flappyDashGame,
        //   backgroundBuilder: (context){
        //     return Container(
          
        //     );
        //   },
        //   ),

        body: Stack(
          children: [

            GameWidget(
              game: _flappyDashGame,
            ),
            if(state.currentPlayingState.isGameOver)
            GameOverWiget(),
            if(state.currentPlayingState.isIdle)
            TapToPlay(),
            if(state.currentPlayingState.isNotGameOver)
              TopScore()
          ],
        ),
        );
      }
    );
  }
}

