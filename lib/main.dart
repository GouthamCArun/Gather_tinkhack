import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gather/first.dart';
import 'package:gather/homescreen.dart';
import 'package:gather/try.dart';
import 'package:http/http.dart' as http;

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: FirstPage());
  }
}
