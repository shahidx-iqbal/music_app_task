import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/services/database_service.dart';
import 'song_notifier.dart';

final dbHelperProvider = Provider<DBHelper>((ref) => DBHelper());

final songNotifierProvider = StateNotifierProvider<SongNotifier, List<SongModel>>((ref) {
  final dbHelper = ref.watch(dbHelperProvider);
  return SongNotifier(dbHelper);
});
