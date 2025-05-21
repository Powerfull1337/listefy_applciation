import 'package:listefy_applciation/features/songs/domain/repository/audio_repository.dart';

class SeekSongUseCase {
  final AudioRepository repository;
  SeekSongUseCase(this.repository);

  Future<void> call(Duration position) async {
    await repository.seek(position);
  }
}