abstract class AudioRepository {
  Future<void> play(String url);
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Duration position);
  Stream<Duration> get onPositionChanged;
  Stream<void> get onCompleted;
}