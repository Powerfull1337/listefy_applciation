import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listefy_applciation/features/songs/presentation/notifiers/audio_controller.dart';


final audioControllerProvider =
    StateNotifierProvider<AudioController, AudioState>((ref) {
  return AudioController();
});
