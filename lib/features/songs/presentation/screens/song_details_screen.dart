import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listefy_applciation/features/songs/domain/entities/song.dart';
import 'package:listefy_applciation/features/songs/presentation/providers/audio_player_provider.dart';
import 'package:listefy_applciation/core/utils/song_format_duration.dart';

class SongDetailsScreen extends ConsumerWidget {
  final Song song;

  const SongDetailsScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider(song));
    final controller = ref.read(audioPlayerProvider(song).notifier);

    final maxDuration = player.totalDuration.inSeconds.toDouble();
    final currentValue = player.currentPosition.inSeconds.clamp(0, maxDuration);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(player.currentSong.title),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                player.currentSong.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(player.currentSong.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(player.currentSong.artist,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7), fontSize: 18)),
            const SizedBox(height: 20),
            Slider(
              value: currentValue.toDouble(),
              max: maxDuration,
              onChanged: controller.seek,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDuration(player.currentPosition),
                    style: const TextStyle(color: Colors.white70)),
                Text(formatDuration(player.totalDuration),
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
                  onPressed: controller.playPrevious,
                ),
                IconButton(
                  icon: Icon(
                    player.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    size: 64,
                    color: Colors.white,
                  ),
                  onPressed: controller.togglePlayPause,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next,
                      color: Colors.white, size: 48),
                  onPressed: controller.playNext,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
