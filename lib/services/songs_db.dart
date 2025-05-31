import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SongDb {
  static final SongDb _instance = SongDb._internal();
  factory SongDb() => _instance;
  SongDb._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'songs.db');

  // delete db
   //await deleteDb();

  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE songs (
          id TEXT PRIMARY KEY,
          title TEXT,
          artist TEXT,
          duration INTEGER,
          filePath TEXT,
          imageUrl TEXT
        )
      ''');
    },
  );
}
 Future<void> deleteDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'songs.db');


    if (_db != null) {
      await _db!.close();
      _db = null;
    }


    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}

