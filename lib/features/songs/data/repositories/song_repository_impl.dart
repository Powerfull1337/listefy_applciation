import 'package:listefy_applciation/core/constants/app_assets.dart';
import 'package:listefy_applciation/features/songs/data/datasources/local_source_datasource.dart';

import '../../domain/entities/song.dart';
import '../../domain/repositories/song_repository.dart';
import '../models/song_model.dart';

class SongRepositoryImpl implements SongRepository {
  final LocalSongDataSource localDataSource;

  SongRepositoryImpl(this.localDataSource);

  @override
  Future<void> addLocalSong(Song song) async {
    await localDataSource.addSong(SongModel(
      id: song.id,
      title: song.title,
      artist: song.artist,
      duration: song.duration,
      filePath: song.filePath,
      imageUrl: AppAssets.logoSvg,
    ));
  }

  @override
  Future<List<Song>> getLocalSongs() async {
    return await localDataSource.getAllSongs();
  }
}
