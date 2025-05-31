import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:listefy_applciation/features/songs/domain/entities/song.dart';

class SongModel extends Song {
   SongModel({
    required super.id,
    required super.title,
    required super.artist,
    required super.duration,
    required super.filePath,
    required super.imageUrl,
  });

  static Future<SongModel> fromFile(File file) async {
    final fileName = file.path.split('/').last;

    final player = AudioPlayer();
    await player.setSourceDeviceFile(file.path);

    Duration? duration;
    try {
      await player.resume(); 
      await Future.delayed(const Duration(milliseconds: 200)); 
      duration = await player.getDuration();
      await player.stop();
      await player.release();
    } catch (e) {
      duration = Duration.zero;
    }

    return SongModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: fileName,
      artist: 'Unknown Artist',
      duration: duration ?? Duration.zero,
      filePath: file.path,
      imageUrl: 'assets/images/default_cover.jpg',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'artist': artist,
        'duration': duration.inMilliseconds,
        'filePath': filePath,
        'imageUrl': imageUrl,
      };

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      duration: Duration(milliseconds: json['duration']),
      filePath: json['filePath'],
      imageUrl: json['imageUrl'],
    );
  }
}

final List<Song> localSongs = [
  Song(
    id: '1',
    title: 'In The End',
    artist: 'Tommee Profitt',
    duration: const Duration(minutes: 3, seconds: 54),
    filePath: 'audio/in_the_end.mp3',
    imageUrl: 'assets/audio_images/in_the_end_image.jpg',
  ),
  Song(
    id: '2',
    title: 'Next To You',
    artist: 'Parasyte OST',
    duration: const Duration(minutes: 2, seconds: 24),
    filePath: 'audio/next_to_you.mp3',
    imageUrl: 'assets/audio_images/next_to_you_image.jpg',
  ),
];
