import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listefy_applciation/features/songs/domain/entities/song.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:listefy_applciation/features/songs/data/models/song_model.dart';

final audioControllerProvider =
    StateNotifierProvider<AudioController, AudioState>(
  (ref) => AudioController(),
);

class AudioController extends StateNotifier<AudioState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Song> _allSongs = localSongs;

  AudioController()
      : super(AudioState(
          currentIndex: 0,
          currentPosition: Duration.zero,
          isPlaying: false,
        )) {
    _init();
  }

  void _init() {
    _audioPlayer.onPositionChanged.listen((position) {
      state = state.copyWith(currentPosition: position);
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      state = state.copyWith(totalDuration: duration);
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      state = state.copyWith(isPlaying: false, currentPosition: Duration.zero);
    });

    _loadSong(state.currentIndex);
  }

  void _loadSong(int index) async {
    final song = _allSongs[index];
    await _audioPlayer.stop();
    await _audioPlayer.setSourceAsset(song.audioUrl);

    state = state.copyWith(
      currentIndex: index,
      currentPosition: Duration.zero,
      totalDuration: song.duration,
      isPlaying: false,
    );
  }

  void setCurrentSong(Song song) {
    final index = _allSongs.indexWhere((s) => s.id == song.id);
    if (index != -1 && index != state.currentIndex) {
      _loadSong(index);
    }
  }

  void playPause() async {
    if (state.isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void seek(double seconds) async {
    await _audioPlayer.seek(Duration(seconds: seconds.toInt()));
  }

  void playNext() {
    if (state.currentIndex < _allSongs.length - 1) {
      _loadSong(state.currentIndex + 1);
    }
  }

  void playPrevious() {
    if (state.currentIndex > 0) {
      _loadSong(state.currentIndex - 1);
    }
  }

  Song get currentSong => _allSongs[state.currentIndex];
  List<Song> get allSongs => _allSongs;
}

class AudioState {
  final int currentIndex;
  final Duration currentPosition;
  final Duration? totalDuration;
  final bool isPlaying;

  AudioState({
    required this.currentIndex,
    required this.currentPosition,
    this.totalDuration,
    required this.isPlaying,
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

