import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listefy_applciation/config/di/service_locator.dart';

import 'package:listefy_applciation/features/songs/presentation/notifiers/audio_controller.dart';




final audioControllerProvider = StateNotifierProvider<AudioController, AudioState>(
  (ref) => AudioController(
    sl(), 
    sl(),
    sl(), 
  ),
);
