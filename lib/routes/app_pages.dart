import 'package:get/get.dart';

import 'app_routes.dart';

import '../app/data/models/pet_model.dart';

import '../app/modules/get_start/get_start_page.dart';
import '../app/modules/login/login_page.dart';
import '../app/modules/register/register_page.dart';
import '../app/modules/views/home_view_page.dart';
import '../app/modules/edit_profile/edit_profile_page.dart';
import '../app/modules/add_pet/add_pet_page.dart';
import '../app/modules/pet_profile/pet_profile_page.dart';

import '../app/modules/login/login_binding.dart';
import '../app/modules/register/register_binding.dart';
import '../app/modules/views/home_view_binding.dart';
import '../app/modules/edit_profile/edit_profile_binding.dart';
import '../app/modules/add_pet/add_pet_binding.dart';

final List<GetPage> appPages = [
  GetPage(
    name: Routes.getStart,
    page: () => const GetStartPage(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 250),
  ),
  GetPage(
    name: Routes.login,
    page: () => const LoginPage(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 250),
    binding: LoginBinding(),
  ),
  GetPage(
    name: Routes.register,
    page: () => const RegisterPage(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 250),
    binding: RegisterBinding(),
  ),
  GetPage(
    name: Routes.home,
    page: () => const HomeViewPage(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 250),
    binding: HomeViewBinding(),
  ),
  GetPage(
    name: Routes.editProfile,
    page: () => const EditProfilePage(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 250),
    binding: EditProfileBinding(),
  ),
  GetPage(
    name: Routes.addPet,
    page: () => const AddPetPage(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 250),
    binding: AddPetBinding(),
  ),
  GetPage(
    name: Routes.petProfile,
    page: () {
      final pet = Get.arguments as Pet;
      return PetProfilePage(pet: pet);
    },
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 320),
  ),
];
