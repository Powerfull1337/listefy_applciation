import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listefy_applciation/app/listefy_app.dart';
import 'package:listefy_applciation/config/di/injection_container.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); 
  runApp(const ProviderScope(child: ListefyApp()));
}

