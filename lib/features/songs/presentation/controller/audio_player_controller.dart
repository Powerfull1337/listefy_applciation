import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:listefy_applciation/config/di/injection_container.dart';
import 'package:listefy_applciation/features/songs/domain/entities/song.dart';

class AudioPlayerState {
  final bool isPlaying;
  final Duration currentPosition;
  final Duration totalDuration;
  final Song currentSong;

  AudioPlayerState({
    required this.isPlaying,
    required this.currentPosition,
    required this.totalDuration,
    required this.currentSong,
  });

  AudioPlayerState copyWith({
    bool? isPlaying,
    Duration? currentPosition,
    Duration? totalDuration,
    Song? currentSong,
  }) {
    return AudioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentPosition: currentPosition ?? this.currentPosition,
      totalDuration: totalDuration ?? this.totalDuration,
      currentSong: currentSong ?? this.currentSong,
    );
  }
}

class AudioPlayerController extends StateNotifier<AudioPlayerState> {
  final AudioPlayer _audioPlayer = sl<AudioPlayer>();
  final List<Song> allSongs;
  int currentIndex;

  AudioPlayerController(Song initialSong, this.allSongs)
      : currentIndex = allSongs.indexWhere((s) => s.id == initialSong.id),
        super(AudioPlayerState(
          isPlaying: false,
          currentPosition: Duration.zero,
          totalDuration: allSongs.firstWhere(
            (s) => s.id == initialSong.id,
            orElse: () => initialSong,
          ).duration,
          currentSong: initialSong,
        )) {
    if (currentIndex == -1) {
      allSongs.insert(0, initialSong);
      currentIndex = 0;
    }
    _initPlayer();
  }

  void _initPlayer() async {
    try {
      if (state.currentSong.audioUrl.isEmpty) {
        print('Audio URL is empty');
        return;
      }

      await _audioPlayer.setSourceAsset(state.currentSong.audioUrl);
    } catch (e, st) {
      print('Error setting source: $e');
      print('StackTrace: $st');
    }

    _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        state = state.copyWith(totalDuration: duration);
      }
    });

    _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        state = state.copyWith(currentPosition: position);
      }
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        state = state.copyWith(isPlaying: false, currentPosition: Duration.zero);
      }
    });
  }

  void togglePlayPause() async {
    if (state.isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
    if (mounted) {
      state = state.copyWith(isPlaying: !state.isPlaying);
    }
  }

  void seek(double seconds) {
    final position = Duration(seconds: seconds.toInt());
    _audioPlayer.seek(position);
  }

  void playNext() async {
    if (currentIndex < allSongs.length - 1) {
      currentIndex++;
      final nextSong = allSongs[currentIndex];
      await _audioPlayer.setSourceAsset(nextSong.audioUrl);
      if (mounted) {
        state = state.copyWith(
          currentSong: nextSong,
          currentPosition: Duration.zero,
          isPlaying: false,
          totalDuration: nextSong.duration,
        );
      }
    }
  }

  void playPrevious() async {
    if (currentIndex > 0) {
      currentIndex--;
      final prevSong = allSongs[currentIndex];
      await _audioPlayer.setSourceAsset(prevSong.audioUrl);
      if (mounted) {
        state = state.copyWith(
          currentSong: prevSong,
          currentPosition: Duration.zero,
          isPlaying: false,
          totalDuration: prevSong.duration,
        );
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
