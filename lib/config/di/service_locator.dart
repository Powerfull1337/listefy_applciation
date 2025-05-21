import 'package:audioplayers/audioplayers.dart';
import 'package:get_it/get_it.dart';
import 'package:listefy_applciation/features/songs/data/repositories/audio_repository_impl.dart';
import 'package:listefy_applciation/features/songs/domain/repository/audio_repository.dart';
import 'package:listefy_applciation/features/songs/domain/usecases/play_song_usecase.dart';
import 'package:listefy_applciation/features/songs/domain/usecases/pause_song_usecase.dart';
import 'package:listefy_applciation/features/songs/domain/usecases/seek_song_usecase.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // AudioPlayer
  sl.registerLazySingleton<AudioPlayer>(() => AudioPlayer());

  // Repositories
  sl.registerLazySingleton<AudioRepository>(() => AudioRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => PlaySongUseCase(sl()));
  sl.registerLazySingleton(() => PauseSongUseCase(sl()));
  sl.registerLazySingleton(() => SeekSongUseCase(sl()));
}
