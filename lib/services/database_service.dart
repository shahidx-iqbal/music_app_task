import 'package:music_app/models/songs_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dart:io' as io;


class DBHelper {

  // Define the table and column names for songs
  final String tableName = "songs";
  final String id = "id";
  final String name = "name";
  final String artist = "artist";
  final String url = "url";
  final String isPlaying = "isPlaying";  // New column for tracking playing state



  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  // Initialize the database and create the "songs" table
  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'songs.db'); 
    var db = await openDatabase(path, version: 1, onCreate: _onCreate );
    return db;
  }

  // Create the "songs" table with the necessary fields
  _onCreate(Database db, int version) async {
    await db.execute(
       'CREATE TABLE $tableName ('
      '$id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$name TEXT NOT NULL, '
      '$artist TEXT NOT NULL, '
      '$url TEXT NOT NULL, '
      '$isPlaying INTEGER NOT NULL DEFAULT 0)'
    );
  }

  // Insert a new song into the database
  Future<SongModel> insert(SongModel songModel) async {
    var dbClient = await db;
    await dbClient!.insert(tableName, songModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return songModel;
  }

  // Retrieve all songs from the database
  Future<List<SongModel>> getSongList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(tableName);
    return queryResult.map((e) => SongModel.fromMap(e)).toList();
  }

  // Update an existing song in the database
  Future<int> updateSong(SongModel songModel) async {
    var dbClient = await db;
    return await dbClient!.update(
      tableName,
      songModel.toMap(),
      where: '$id = ?',
      whereArgs: [songModel.id],
    );
  }


 // Update playback state for a song by ID
  Future<void> updateSongPlaybackState(int songId, bool isPlayingState) async {
    var dbClient = await db;

    // Reset all songs to not playing
    await dbClient!.update(
      tableName,
      {'$isPlaying': 0}, // Set isPlaying to 0 (not playing) for all songs
    );

    // Set the specific song to playing or not
    await dbClient!.update(
      tableName,
      {'isPlaying': isPlayingState ? 1 : 0},  // Update the isPlaying field
      where: 'id = ?',
      whereArgs: [songId],
    );
  }


  // Retrieve the currently playing song
  Future<SongModel?> getCurrentSong() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient!.query(
      tableName,
      where: '$isPlaying = ?', // Check if the song is playing
      whereArgs: [1],  // '1' means it's currently playing
      limit: 1
    );
    if (result.isNotEmpty) {
      return SongModel.fromMap(result.first);
    }
    return null; // No song currently playing
  }


  // Delete a song from the database by its ID
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Clear all entries in the songs table
  Future deleteTableContent() async {
    var dbClient = await db;
    return await dbClient!.delete(tableName);
  }

  // Close the database connection
  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
