import '../entities/song.dart';

abstract interface class SongRepository {
  Future<void> addLocalSong(Song song);
  Future<List<Song>> getLocalSongs();
}
