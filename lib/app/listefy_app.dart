import 'package:flutter/material.dart';
import 'package:listefy_applciation/config/routes/app_router.dart';
import 'package:listefy_applciation/config/routes/app_routes.dart';
import 'package:listefy_applciation/core/theme/app_theme.dart';

class ListefyApp extends StatelessWidget {
  const ListefyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listefy',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
