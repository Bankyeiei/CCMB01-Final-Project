import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'core/theme/theme.dart' as theme;

import 'app/modules/get_start/get_start_page.dart';
import 'app/modules/login/login_page.dart';
import 'app/modules/register/register_page.dart';

import 'app/app_binding.dart';
import 'app/modules/login/login_binding.dart';
import 'app/modules/register/register_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      initialBinding: AppBinding(),
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 250),
          binding: LoginPageBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => RegisterPage(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 250),
          binding: RegisterBinding(),
        ),
      ],
      home: const GetStartPage(),
    );
  }
}
