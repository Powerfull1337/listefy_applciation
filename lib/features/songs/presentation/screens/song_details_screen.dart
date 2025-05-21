import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listefy_applciation/core/utils/format_minute_seconds.dart';
import 'package:listefy_applciation/features/songs/presentation/providers/audio_state_provider.dart';

class SongDetailsScreen extends ConsumerWidget {
  const SongDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(audioControllerProvider);
    final controller = ref.read(audioControllerProvider.notifier);
    final song = controller.currentSong;

    const maxDuration = 1.0;
    final currentValue =
        state.currentPosition.inSeconds.toDouble().clamp(0.0, maxDuration);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(song.title),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                song.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              song.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              song.artist,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Slider(
              value: currentValue,
              max: maxDuration,
              min: 0.0,
              onChanged: (value) =>
                  controller.seek(Duration(seconds: value.toInt())),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDuration(state.currentPosition),
                    style: const TextStyle(color: Colors.white70)),
                Text(formatDuration(state.totalDuration),
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous,
                      color: Colors.white, size: 48),
                  onPressed: controller.previous,
                ),
                IconButton(
                  icon: Icon(
                    state.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    size: 64,
                    color: Colors.white,
                  ),
                  onPressed: controller.pause,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next,
                      color: Colors.white, size: 48),
                  onPressed: controller.next,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
