import 'package:flutter/material.dart';
import 'package:listefy_applciation/core/theme/app_theme.dart';
import 'package:listefy_applciation/features/auth/presentation/screens/auth_screen.dart';

class ListefyApp extends StatelessWidget {
  const ListefyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Listefy',
      theme: AppTheme.darkTheme,
      home: const AuthScreen(),
    );
  }
}
