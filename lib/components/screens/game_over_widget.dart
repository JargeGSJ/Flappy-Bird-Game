

import 'dart:ui';

import 'package:flappy_dash_game/bloc/game/game_cubit.dart' show GameCubit, GameState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameOverWiget extends StatelessWidget {
  const GameOverWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state){
        return BackdropFilter(
          filter:ImageFilter.blur(sigmaX: 6, sigmaY: 6) ,
          child: Container(
            color: Colors.black54,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Game Over", 
                  style: TextStyle(
                    fontSize: 45,fontWeight: 
                    FontWeight.bold,
                    color: Colors.amber,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 4
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Score : ${state.currentScore}",
                    style: TextStyle(
                      fontSize: 22,fontWeight: 
                      FontWeight.bold,
                      color: Colors.amber,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 4
                      ),
                  ),
                  SizedBox(height: 60,),
                  ElevatedButton(onPressed: (){
                      BlocProvider.of<GameCubit>(context).restartGame();
                }, child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Restart Game!", 
                  style: TextStyle(
                    color: const Color.fromARGB(255, 136, 27, 114),
                    fontSize: 22,
                    letterSpacing: 2
                  ),),
                ))
                
                ],
              ),
              
            ),
          ),
        );
      });
   

  }
}