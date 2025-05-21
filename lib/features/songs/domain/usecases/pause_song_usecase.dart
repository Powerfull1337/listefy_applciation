import 'package:listefy_applciation/features/songs/domain/repository/audio_repository.dart';

class PauseSongUseCase {
  final AudioRepository repository;
  PauseSongUseCase(this.repository);

  Future<void> call() async {
    await repository.pause();
  }
}