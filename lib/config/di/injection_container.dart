import 'package:get_it/get_it.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:listefy_applciation/features/songs/data/datasources/local_source_datasource.dart';
import 'package:listefy_applciation/features/songs/domain/usecase/add_local_song_usecase.dart';
import 'package:listefy_applciation/features/songs/domain/usecase/get_local_songs_usecase.dart';

import '../../features/songs/data/repositories/song_repository_impl.dart';
import '../../features/songs/domain/repositories/song_repository.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // AudioPlayer
  sl.registerLazySingleton<AudioPlayer>(() => AudioPlayer());

  // Data Sources
  sl.registerLazySingleton<LocalSongDataSource>(() => LocalSongDataSource());

  // Repositories
  sl.registerLazySingleton<SongRepository>(() => SongRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton<AddLocalSongUseCase>(() => AddLocalSongUseCase(sl()));
  sl.registerLazySingleton<GetLocalSongsUseCase>(() => GetLocalSongsUseCase(sl()));

}
