// lib/config/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:listefy_applciation/features/auth/presentation/screens/auth_screen.dart';
import 'package:listefy_applciation/features/songs/domain/entities/song.dart';

import 'package:listefy_applciation/home_screen.dart';

import 'app_routes.dart';

import 'package:listefy_applciation/features/songs/presentation/screens/song_details_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case AppRoutes.songDetails:
        // final song = settings.arguments as Song;
        return MaterialPageRoute(
          builder: (_) => const SongDetailsScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Something went wrong')),
          ),
        );
    }
  }
}
