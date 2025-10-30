import 'dart:async';
// import 'package:flutter_soloud/flutter_soloud.dart';

// class AudioHelper {

//   late SoLoud _soLoud;
//   late AudioSource _backgroundSource;
//   late SoundHandle _playBackgroundAudio;

//   late AudioSource _scoreSource;



//   Future<void> initialize() async {
//     _soLoud =SoLoud.instance;
//     if(_soLoud.isInitialized){
//       return;
//     }

//   await _soLoud.init();
//   _backgroundSource = await _soLoud.loadAsset("assets/audio/background.mpx");
//   _scoreSource = await _soLoud.loadAsset("assets/audio/score.mp3");

//   }

//   void playBackgroundAudio() async{
//      _playBackgroundAudio = await _soLoud.play(_backgroundSource,);
//      _soLoud.getProtectVoice(_playBackgroundAudio!,);
//   }

//   void stopBackgroundAudio(){
//     if(_playBackgroundAudio == null){
//       return;
//     }
//     _soLoud.fadeVolume(_playBackgroundAudio, 0.0, Duration(milliseconds: 500));
//   }


//   void playScoreCollectSound() async{
//    await _soLoud.play(_scoreSource);
//   }

// }


// =================================


import 'package:just_audio/just_audio.dart';

class AudioHelper {
  static final AudioHelper _instance = AudioHelper._internal();
  factory AudioHelper() => _instance;
  AudioHelper._internal();

  late final AudioPlayer _backgroundPlayer;
  late final AudioPlayer _scorePlayer;

  bool _initialized = false;

  /// Initialize audio players
  Future<void> initialize() async {
    if (_initialized) return;

    _backgroundPlayer = AudioPlayer();
    _scorePlayer = AudioPlayer();

    await _backgroundPlayer.setAsset('assets/audio/background.mp3');
    await _scorePlayer.setAsset('assets/audio/score.mp3');

    await _backgroundPlayer.setLoopMode(LoopMode.all);
    _initialized = true;
  }

  /// Play background music
  Future<void> playBackgroundAudio() async {
    if (!_initialized) return;
    if (_backgroundPlayer.playing) return;

    await _backgroundPlayer.setVolume(1.0);
    await _backgroundPlayer.play();
  }

  /// Stop background music with 0.5s fade
  Future<void> stopBackgroundAudio() async {
    if (!_initialized) return;
    if (!_backgroundPlayer.playing) return;

    await _fadeVolume(_backgroundPlayer,
        from: _backgroundPlayer.volume, to: 0.0, duration: const Duration(milliseconds: 500));

    await _backgroundPlayer.stop();
    await _backgroundPlayer.setVolume(1.0); // reset for next play
  }

  /// Play score collect sound
  Future<void> playScoreCollectSound() async {
    if (!_initialized) return;

    await _scorePlayer.seek(Duration.zero);
    await _scorePlayer.play();
  }

  /// Dispose all players
  void dispose() {
    _backgroundPlayer.dispose();
    _scorePlayer.dispose();
  }

  /// Helper: fade volume over time since just_audio has no built-in duration
  Future<void> _fadeVolume(
    AudioPlayer player, {
    required double from,
    required double to,
    required Duration duration,
    int steps = 20,
  }) async {
    // Clamp inputs
    from = from.clamp(0.0, 1.0);
    to = to.clamp(0.0, 1.0);

    final stepDuration = Duration(milliseconds: (duration.inMilliseconds / steps).round());
    final delta = (to - from) / steps;

    // Start from current volume to avoid jumps
    double current = from;
    for (int i = 0; i < steps; i++) {
      current += delta;
      await player.setVolume(current.clamp(0.0, 1.0));
      await Future.delayed(stepDuration);
    }
    // Ensure final value is exact
    await player.setVolume(to);
  }
}
