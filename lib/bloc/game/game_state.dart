// part of 'game_cubit.dart';



// // import 'package:equatable/equatable.dart' show Equatable;


// import 'package:equatable/equatable.dart' show EquatableMixin;

// class GameState extends EquatableMixin{

//  const GameState(
//     this.currentScore = 0,
//     this.currectPlayingState = PlayingState.none,
//  );

//  final int currentScore;
//  final PlayingState currentPlayingState;
 
//   final dynamic currectPlayingState;


// // final class GameInitial extends GameState{
// //   @override
// List<Object> get pros => [
//    currentScore,
//    currentPlayingState,
// ];
// }


// enum PlayingState{
//    none,
//    playing,
//    paused,
//    gameOver
// }






// part of 'game_cubit.dart';



// // import 'package:equatable/equatable.dart' show Equatable;


// import 'package:equatable/equatable.dart' show EquatableMixin;

// class GameState extends EquatableMixin{

//  const GameState(
//     this.currentScore = 0,
//     this.currectPlayingState = PlayingState.none,
//  );

//  final int currentScore;
//  final PlayingState currentPlayingState;
 
//   final dynamic currectPlayingState;


// // final class GameInitial extends GameState{
// //   @override
// List<Object> get pros => [
//    currentScore,
//    currentPlayingState,
// ];
// }


// enum PlayingState{
//    none,
//    playing,
//    paused,
//    gameOver
// }






part of 'game_cubit.dart';


class GameState with EquatableMixin {
  const GameState({
    this.currentScore = 0,
    this.currentPlayingState = PlayingState.none,
  });

  final int currentScore;
  final PlayingState currentPlayingState;

  GameState copyWith({
    int? currentScore,
    PlayingState? currentPlayingState,
  }) =>
      GameState(
        currentScore: currentScore ?? this.currentScore,
        currentPlayingState: currentPlayingState ?? this.currentPlayingState,
      );

  @override
  List<Object> get props => [
        currentScore,
        currentPlayingState,
      ];
}

enum PlayingState {
  none,
  playing,
  paused,
  gameOver;


  bool get isPlaying => this == PlayingState.playing;

  bool get isNotPlaying => !isPlaying;

  bool get isGameOver => this == PlayingState.gameOver;

  bool get isNotGameOver => !isGameOver;

  bool get isIdle => this == PlayingState.none;

  bool get isPaused => this == PlayingState.paused;
}