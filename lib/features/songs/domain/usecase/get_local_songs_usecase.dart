import '../entities/song.dart';
import '../repositories/song_repository.dart';

class GetLocalSongsUseCase {
  final SongRepository repository;

  GetLocalSongsUseCase(this.repository);

  Future<List<Song>> call() async {
    return await repository.getLocalSongs();
  }
}
