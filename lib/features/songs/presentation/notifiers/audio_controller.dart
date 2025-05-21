import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listefy_applciation/features/songs/domain/entities/song.dart';

import 'package:listefy_applciation/features/songs/data/models/song_model.dart';
import 'package:listefy_applciation/features/songs/domain/usecases/pause_song_usecase.dart';
import 'package:listefy_applciation/features/songs/domain/usecases/play_song_usecase.dart';
import 'package:listefy_applciation/features/songs/domain/usecases/seek_song_usecase.dart';

class AudioController extends StateNotifier<AudioState> {
  final PlaySongUseCase _play;
  final PauseSongUseCase _pause;
  final SeekSongUseCase _seek;

  final List<Song> _songs = localSongs;

  AudioController(this._play, this._pause, this._seek)
      : super(AudioState(currentIndex: 0, currentPosition: Duration.zero, isPlaying: false)) {
    _play.onCompleted.listen((_) => _handleCompletion());
    _play.onPositionChanged.listen((pos) => state = state.copyWith(currentPosition: pos));
  }

  Future<void> playCurrent() async {
    final song = _songs[state.currentIndex];
    await _play(song.audioUrl);
    state = state.copyWith(isPlaying: true);
  }

  Future<void> pause() async {
    await _pause();
    state = state.copyWith(isPlaying: false);
  }

  void next() {
    final nextIndex = (state.currentIndex + 1) % _songs.length;
    state = state.copyWith(currentIndex: nextIndex);
    playCurrent();
  }

  void previous() {
    final prevIndex = (state.currentIndex - 1 + _songs.length) % _songs.length;
    state = state.copyWith(currentIndex: prevIndex);
    playCurrent();
  }

  void seek(Duration position) async {
    await _seek(position);
  }

  void _handleCompletion() {
    next();
  }

  Song get currentSong => _songs[state.currentIndex];
}

class AudioState {
  final int currentIndex;
  final Duration currentPosition;
  final Duration totalDuration;  
  final bool isPlaying;

  AudioState({
    required this.currentIndex,
    required this.currentPosition,
    required this.isPlaying,
    this.totalDuration = Duration.zero,  
  });

  AudioState copyWith({
    int? currentIndex,
    Duration? currentPosition,
    Duration? totalDuration,   
    bool? isPlaying,
  }) {
    return AudioState(
      currentIndex: currentIndex ?? this.currentIndex,
      currentPosition: currentPosition ?? this.currentPosition,
      totalDuration: totalDuration ?? this.totalDuration,  
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
