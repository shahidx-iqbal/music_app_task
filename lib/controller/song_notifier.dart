import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/services/database_service.dart';

class SongNotifier extends StateNotifier<List<SongModel>> {
  final DBHelper dbHelper;

  SongNotifier(this.dbHelper) : super([]) {
    _fetchSongs();
  }

//fetch song from sql database 
  Future<void> _fetchSongs() async {
    final songs = await dbHelper.getSongList();
    state = songs;
  }
//add song to sql database
  Future<void> addSong(SongModel song) async {
    await dbHelper.insert(song);
    _fetchSongs();
  }
//update song to sql database

  Future<void> updateSong(SongModel song) async {
    await dbHelper.updateSong(song);
    _fetchSongs();
  }

  Future<void> updateSongPlaybackState(int id, bool isPlaying) async {
    await dbHelper.updateSongPlaybackState(id, isPlaying);
    _fetchSongs();
  }
//delete song to sql database
  Future<void> deleteSong(int id) async {
    print(id);
    await dbHelper.delete(id);
    _fetchSongs();
  }
}
