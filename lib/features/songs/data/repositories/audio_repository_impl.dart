import 'package:audioplayers/audioplayers.dart';
import 'package:listefy_applciation/features/songs/domain/repository/audio_repository.dart';

class AudioRepositoryImpl implements AudioRepository {
  final AudioPlayer _player;
AudioRepositoryImpl(this._player);
  @override
  Future<void> play(String url) async {
    await _player.stop();
    await _player.setSourceAsset(url);
    await _player.resume();
  }

  @override
  Future<void> pause() async => _player.pause();

  @override
  Future<void> stop() async => _player.stop();

  @override
  Future<void> seek(Duration position) async => _player.seek(position);

  @override
  Stream<Duration> get onPositionChanged => _player.onPositionChanged;

  @override
  Stream<void> get onCompleted => _player.onPlayerComplete;
}