import 'package:get_it/get_it.dart';
import 'package:audioplayers/audioplayers.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerLazySingleton<AudioPlayer>(() => AudioPlayer());
}
