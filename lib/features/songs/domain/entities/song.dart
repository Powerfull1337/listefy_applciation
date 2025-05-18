class Song {
  final String id;
  final String title;
   final String artist;
  // final String album;
   final Duration duration;
   final String audioUrl;
   final String imageUrl;
  // final String coverUrl;
  // final DateTime releaseDate;
  // final List<String> genres;
  // final bool isExplicit;

  // // Optional:
  // final int playCount;
  // final String lyrics;
  // final String uploaderId;
  // final DateTime createdAt;
  // final DateTime? updatedAt;

  Song({
    required this.id,
    required this.title,
     required this.artist,
    // required this.album,
     required this.duration,
     required this.audioUrl,
     required this.imageUrl,
    // required this.coverUrl,
    // required this.releaseDate,
    // required this.genres,
    // required this.isExplicit,
    // this.playCount = 0,
    // this.lyrics = '',
    // required this.uploaderId,
    // required this.createdAt,
    // this.updatedAt,
  });
}
