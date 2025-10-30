import 'package:flappy_dash_game/bloc/game/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TopScore extends StatelessWidget {
  const TopScore({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state){
        return Align(
          alignment: Alignment.topCenter,
          
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Text(state.currentScore.toString(), 
            style: TextStyle(
              fontSize: 34, 
              fontStyle: FontStyle.italic,
              color: Colors.black,
              ),
            ),
          )
        );
      }
    );
  }
}