
import 'package:flappy_dash_game/audio_helper.dart' show AudioHelper;
import 'package:flappy_dash_game/bloc/game/game_cubit.dart';
import 'package:flappy_dash_game/main_page.dart';
import 'package:flappy_dash_game/service_locator.dart' show setupServiceLocator, getIt;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GameCubit(
        getIt.get<AudioHelper>(),
      ),
      child: MaterialApp(
        title: 'Flappy Dash',
        // theme: ThemeData(fontFamily: 'Chewy'),
        theme: ThemeData(fontFamily: "Chewy"),
        home: MainPage(),
      ),
    );
  }
}