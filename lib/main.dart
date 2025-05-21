import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listefy_applciation/app/listefy_app.dart';
import 'package:listefy_applciation/config/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // GetIt init
  runApp(const ProviderScope(child: ListefyApp()));
}
