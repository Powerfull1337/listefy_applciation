import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listefy_applciation/config/di/injection_container.dart';
import 'package:listefy_applciation/features/songs/domain/usecase/add_local_song_usecase.dart';

import '../../domain/entities/song.dart';


final addSongControllerProvider = Provider<AddSongController>((ref) {
  return AddSongController(sl<AddLocalSongUseCase>());
});

class AddSongController {
  final AddLocalSongUseCase _useCase;

  AddSongController(this._useCase);

  Future<void> addSong(Song song) async {
    await _useCase(song);
  }
}
