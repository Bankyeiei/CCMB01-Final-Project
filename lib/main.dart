import 'package:coco/app/modules/views/home_view_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/theme/theme.dart' as theme;

import 'app/modules/get_start/get_start_page.dart';
import 'app/modules/login/login_page.dart';
import 'app/modules/register/register_page.dart';
import 'app/modules/views/home_view_page.dart';
import 'app/modules/edit_profile/edit_profile_page.dart';
import 'app/modules/add_pet/add_pet_page.dart';

import 'app/app_binding.dart';
import 'app/modules/login/login_binding.dart';
import 'app/modules/register/register_binding.dart';
import 'app/modules/edit_profile/edit_profile_binding.dart';
import 'app/modules/add_pet/add_pet_binding.dart';

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
    String firstPage = '';
    if (box.read('isLoggedIn')) {
      firstPage = '/home';
    } else if (box.read('hasLoggedIn')) {
      firstPage = '/login';
    } else {
      firstPage = '/get_start';
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.themeData,
      initialRoute: firstPage,
      initialBinding: AppBinding(),
      getPages: [
        GetPage(
          name: '/get_start',
          page: () => const GetStartPage(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 250),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 250),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterPage(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 250),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeViewPage(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 250),
          binding: HomeViewBinding(),
        ),
        GetPage(
          name: '/edit_profile',
          page: () => const EditProfilePage(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 250),
          binding: EditProfileBinding(),
        ),
        GetPage(
          name: '/add_pet',
          page: () => const AddPetPage(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 250),
          binding: AddPetBinding(),
        ),
      ],
    );
  }
}
