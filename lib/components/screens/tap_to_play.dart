
import 'package:flappy_dash_game/bloc/game/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TapToPlay extends StatelessWidget {
  const TapToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit,GameState>(builder: (context, state){
      return  IgnorePointer(
        child: Align(
          alignment: Alignment(0, 0.4),
          child: Text(
            "TAP TO PLAY", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35, 
              color: Colors.lightBlue,
              letterSpacing: 5,
              ),
            ).animate(
              onPlay: (controller) => controller.repeat(reverse: true),
            ).scale(
              begin: Offset(1.0, 1.0),
              end: Offset(1.2, 1.2),
              duration: Duration(milliseconds: 500)
            )
        ),
      );
            
    });
  }
}