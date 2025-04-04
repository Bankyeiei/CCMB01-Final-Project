import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'theme/theme.dart' as theme;
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.themeData,
      home: HomeScreen()
    );
  }
}
