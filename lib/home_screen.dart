import 'package:flutter/material.dart';
import 'package:listefy_applciation/config/routes/app_routes.dart';
import 'package:listefy_applciation/features/songs/data/models/song_model.dart';
import 'package:listefy_applciation/features/songs/domain/entities/song.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const CircleAvatar(),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.settings),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Your Songs'),
          const SizedBox(height: 16),
          Column(
            children: localSongs
                .map((song) => _buildSongTile(song, context))
                .toList(),
          ),

          // Column(
          //   children: List.generate(
          //     6,
          //     (index) => Padding(
          //       padding: const EdgeInsets.only(bottom: 6),
          //       child: _buildShortcutTile('Playlist $index'),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_music), label: 'Library'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSongTile(Song song, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.songDetails,
          arguments: song,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                song.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    song.artist,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              _formatDuration(song.duration),
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}


  // Widget _buildHorizontalList() {
  //   return SizedBox(
  //     height: 180,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: 10,
  //       itemBuilder: (context, index) {
  //         return Container(
  //           width: 140,
  //           margin: const EdgeInsets.only(right: 12),
  //           decoration: BoxDecoration(
  //             color: Colors.grey.shade900,
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 height: 100,
  //                 decoration: const BoxDecoration(
  //                   color: Colors.grey,
  //                   borderRadius:
  //                       BorderRadius.vertical(top: Radius.circular(8)),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text('Title $index',
  //                         style: const TextStyle(color: Colors.white)),
  //                     const SizedBox(height: 4),
  //                     Text('Subtitle',
  //                         style: TextStyle(
  //                             color: Colors.white.withOpacity(0.7),
  //                             fontSize: 12)),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

