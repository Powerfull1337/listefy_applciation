import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:listefy_applciation/features/songs/domain/entities/song.dart';
import 'package:listefy_applciation/features/songs/data/models/song_model.dart';

class SongDetailsScreen extends StatefulWidget {
  final Song song;

  const SongDetailsScreen({super.key, required this.song});

  @override
  State<SongDetailsScreen> createState() => _SongDetailsScreenState();
}

class _SongDetailsScreenState extends State<SongDetailsScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  Duration? totalDuration;

  late List<Song> allSongs;
  late int currentIndex;

  @override
  void initState() {
    super.initState();

    allSongs = localSongs;
    currentIndex = allSongs.indexWhere((s) => s.id == widget.song.id);

    _initAudio();
  }

  Future<void> _initAudio() async {
    await _audioPlayer.stop();

    final currentSong = allSongs[currentIndex];
    await _audioPlayer.setSourceAsset(currentSong.audioUrl);

    setState(() {
      isPlaying = false;
      currentPosition = Duration.zero;
      totalDuration = currentSong.duration;
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        totalDuration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        currentPosition = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      if (currentPosition == Duration.zero) {
        await _audioPlayer.setSourceAsset(allSongs[currentIndex].audioUrl);
      }
      await _audioPlayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _seek(double seconds) {
    _audioPlayer.seek(Duration(seconds: seconds.toInt()));
  }

  void _playNext() {
    if (currentIndex < allSongs.length - 1) {
      currentIndex++;
      _initAudio();
    }
  }

  void _playPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
      _initAudio();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = allSongs[currentIndex];

    final maxDuration = totalDuration?.inSeconds.toDouble() ?? 1.0;
    final currentValue =
        currentPosition.inSeconds.toDouble().clamp(0.0, maxDuration);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(currentSong.title),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                currentSong.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              currentSong.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              currentSong.artist,
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
              onChanged: (value) {
                _seek(value);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(currentPosition),
                    style: const TextStyle(color: Colors.white70)),
                Text(_formatDuration(totalDuration ?? Duration.zero),
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
                  onPressed: _playPrevious,
                ),
                IconButton(
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    size: 64,
                    color: Colors.white,
                  ),
                  onPressed: _togglePlayPause,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next,
                      color: Colors.white, size: 48),
                  onPressed: _playNext,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
