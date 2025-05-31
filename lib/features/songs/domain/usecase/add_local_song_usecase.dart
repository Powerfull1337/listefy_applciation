import '../entities/song.dart';
import '../repositories/song_repository.dart';

class AddLocalSongUseCase {
  final SongRepository repository;

  AddLocalSongUseCase(this.repository);

  Future<void> call(Song song) async {
    return await repository.addLocalSong(song);
  }
}
