import 'package:flutter/services.dart';

class MusicService {
  static const platform = MethodChannel('com.example.music_app/playback');

  Future<void> startService(String title, String artist, bool isPlaying) async {
    try {
      await platform.invokeMethod('startService', {
        'title': title,
        'artist': artist,
        'isPlaying': isPlaying,
      });
    } on PlatformException catch (e) {
      print("Failed to start service: '${e.message}'.");
    }
  }

  Future<void> stopService(String title, String artist, bool isPlaying) async {
    try {
      await platform.invokeMethod('stopService', {
        'title': title,
        'artist': artist,
        'isPlaying': isPlaying,
      });
    } on PlatformException catch (e) {
      print("Failed to stop service: '${e.message}'.");
    }
  }
}
