import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listefy_applciation/app/listefy_app.dart';

void main() {
  runApp(
    const ProviderScope(child: ListefyApp()),
  );
}
