import 'package:flutter/material.dart';

class SpotifyHomePage extends StatelessWidget {
  const SpotifyHomePage({super.key});

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
          _buildSectionTitle('Your Playlist'),
          const SizedBox(height: 16),
          Column(
            children: List.generate(
              6,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: _buildShortcutTile('Playlist $index'),
              ),
            ),
          ),
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

  Widget _buildShortcutTile(String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Зображення
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 20),
          // Назва плейліста
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
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

