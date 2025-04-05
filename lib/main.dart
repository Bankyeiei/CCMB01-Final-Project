import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme/theme.dart' as theme;

import 'app/modules/get_start/get_start.dart';
import 'app/modules/login/login.dart';

import 'app/modules/login/login_page_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.themeData,
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          binding: LoginPageBinding(),
        ),
      ],
      home: const GetStartPage(),
    );
  }
}
