import 'package:listefy_applciation/features/songs/domain/entities/song.dart';

class SongModel extends Song {
  SongModel({
    required super.id,
    required super.title,
    required super.artist,
    required super.duration,
    required super.audioUrl,
    required super.imageUrl,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      duration: Duration(seconds: json['duration']),
      audioUrl: json['audioUrl'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'artist': artist,
        'duration': duration.inSeconds,
        'audioUrl': audioUrl,
        'imageUrl': imageUrl,
      };
}

final List<Song> localSongs = [
  Song(
    id: '1',
    title: 'In The End',
    artist: 'Tommee Profitt',
    duration: const Duration(minutes: 3, seconds: 54),
    audioUrl: 'audio/in_the_end.mp3',
    imageUrl: 'assets/audio_images/in_the_end_image.jpg',
  ),
  Song(
    id: '2',
    title: 'Next To You',
    artist: 'Parasyte OST',
    duration: const Duration(minutes: 2, seconds: 24),
    audioUrl: 'audio/next_to_you.mp3',
    imageUrl: 'assets/audio_images/next_to_you_image.jpg',
  ),
];
