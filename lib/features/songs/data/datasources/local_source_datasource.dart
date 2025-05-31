

import 'package:listefy_applciation/features/songs/data/models/song_model.dart';
import 'package:listefy_applciation/services/songs_db.dart';
import 'package:sqflite/sqflite.dart';

class LocalSongDataSource {
  final db = SongDb();

  Future<void> addSong(SongModel song) async {
    final database = await db.db;
    await database.insert('songs', song.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<SongModel>> getAllSongs() async {
    final database = await db.db;
    final result = await database.query('songs');
    return result.map((e) => SongModel.fromJson(e)).toList();
  }
}
