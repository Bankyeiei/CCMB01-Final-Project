import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/theme/theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

import 'app/app_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    box.writeIfNull('hasLoggedIn', false);
    box.writeIfNull('isLoggedIn', false);
    box.writeIfNull('uid', '');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: Routes.chooseInitialRoute(box),
      initialBinding: AppBinding(),
      getPages: appPages,
    );
  }
}
