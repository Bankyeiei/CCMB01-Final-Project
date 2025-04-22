import 'package:get_storage/get_storage.dart';

class Routes {
  static const getStart = '/get_start';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const editProfile = '/edit_profile';
  static const addPet = '/add_pet';
  static const petProfile = '/pet_profile';
  static const editPet = '/edit_pet';
  static const addAppointment = '/add_appointment';

  static String chooseInitialRoute(GetStorage box) {
    if (box.read('isLoggedIn')) {
      return home;
    } else if (box.read('hasLoggedIn')) {
      return login;
    }
    return getStart;
  }
}
