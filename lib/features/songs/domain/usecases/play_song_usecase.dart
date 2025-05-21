import 'package:audioplayers/audioplayers.dart';

class PlaySongUseCase {
  final AudioPlayer _player;

  PlaySongUseCase(this._player);

  Future<void> call(String path) async {
    await _player.play(AssetSource(path));
  }

  Stream<Duration> get onCompleted => _player.onPlayerComplete.map((_) => Duration.zero);
  Stream<Duration> get onPositionChanged => _player.onPositionChanged;
  Stream<Duration> get onDurationChanged => _player.onDurationChanged;
}
