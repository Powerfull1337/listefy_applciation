import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listefy_applciation/features/songs/data/models/song_model.dart';
import 'package:listefy_applciation/features/songs/domain/entities/song.dart';
import 'package:listefy_applciation/shared/providers/audio_player_controller.dart';

final audioPlayerProvider = StateNotifierProvider.autoDispose
    .family<AudioPlayerController, AudioPlayerState, Song>(
  (ref, song) => AudioPlayerController(song, localSongs),
);
