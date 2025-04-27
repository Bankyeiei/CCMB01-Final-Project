import 'package:get/get.dart';

import 'app_routes.dart';

import '../app/data/models/appointment_model.dart';
import '../app/data/models/pet_model.dart';
import '../app/data/models/journal_model.dart';

import '../app/modules/get_start/get_start_page.dart';
import '../app/modules/login/login_page.dart';
import '../app/modules/register/register_page.dart';
import '../app/modules/views/home_view_page.dart';
import '../app/modules/edit_profile/edit_profile_page.dart';
import '../app/modules/pet/add_pet/add_pet_page.dart';
import '../app/modules/pet/pet_profile/pet_profile_page.dart';
import '../app/modules/pet/edit_pet/edit_pet_page.dart';
import '../app/modules/appointment/add_appointment/add_appointment_page.dart';
import '../app/modules/appointment/appointment_detail/appointment_detail_page.dart';
import '../app/modules/appointment/edit_appointment/edit_appointment_page.dart';
import '../app/modules/pet/grooming_records/grooming_records_page.dart';
import '../app/modules/pet/vaccinations_records/vaccinations_records_page.dart';
import '../app/modules/journal/add_journal/add_journal_page.dart';
import '../app/modules/journal/journal_detail/journal_detail_page.dart';
import '../app/modules/journal/edit_journal/edit_joutnal_binding.dart';
import '../app/modules/pet/journal_records/journal_records_page.dart';

import '../app/modules/login/login_binding.dart';
import '../app/modules/register/register_binding.dart';
import '../app/modules/views/home_view_binding.dart';
import '../app/modules/edit_profile/edit_profile_binding.dart';
import '../app/modules/pet/add_pet/add_pet_binding.dart';
import '../app/modules/pet/pet_profile/pet_profile_binding.dart';
import '../app/modules/pet/edit_pet/edit_pet_binding.dart';
import '../app/modules/appointment/add_appointment/add_appointment_binding.dart';
import '../app/modules/appointment/appointment_detail/appointment_detail_binding.dart';
import '../app/modules/appointment/edit_appointment/edit_appointment_binding.dart';
import '../app/modules/pet/grooming_records/grooming_records_binding.dart';
import '../app/modules/pet/vaccinations_records/vaccinations_records_binding.dart';
import '../app/modules/journal/add_journal/add_journal_binding.dart';
import '../app/modules/journal/edit_journal/edit_journal_page.dart';

final List<GetPage> appPages = <GetPage>[
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
      final petId = Get.arguments as String;
      return PetProfilePage(petId: petId);
    },
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 320),
    binding: PetProfileBinding(),
  ),
  GetPage(
    name: Routes.editPet,
    page: () {
      final pet = Get.arguments as Pet;
      return EditPetPage(pet: pet);
    },
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 250),
    binding: EditPetBinding(),
  ),
  GetPage(
    name: Routes.addAppointment,
    page: () {
      final petId = Get.arguments as String?;
      return AddAppointmentPage(petId: petId);
    },
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 250),
    binding: AddAppointmentBinding(),
  ),
  GetPage(
    name: Routes.appointmentDetail,
    page: () {
      final appointmentId = Get.arguments as String;
      return AppointmentDetailPage(appointmentId: appointmentId);
    },
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 250),
    binding: AppointmentDetailBinding(),
  ),
  GetPage(
    name: Routes.editAppointment,
    page: () {
      final appointment = Get.arguments as Appointment;
      return EditAppointmentPage(appointment: appointment);
    },
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 250),
    binding: EditAppointmentBinding(),
  ),
  GetPage(
    name: Routes.groomingRecords,
    page: () {
      final petId = Get.arguments as String;
      return GroomingRecordsPage(petId: petId);
    },
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 200),
    binding: GroomingRecordsBinding(),
  ),
  GetPage(
    name: Routes.vaccinationRecords,
    page: () {
      final petId = Get.arguments as String;
      return VaccinationsRecordsPage(petId: petId);
    },
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 200),
    binding: VaccinationsRecordsBinding(),
  ),
  GetPage(
    name: Routes.addJournal,
    page: () {
      final petId = Get.arguments as String?;
      return AddJournalPage(petId: petId);
    },
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 250),
    binding: AddJournalBinding(),
  ),
  GetPage(
    name: Routes.journalDetail,
    page: () {
      final journalId = Get.arguments as String;
      return JournalDetailPage(journalId: journalId);
    },
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 250),
  ),
  GetPage(
    name: Routes.editJournal,
    page: () {
      final journal = Get.arguments as Journal;
      return EditJournalPage(journal: journal);
    },
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 250),
    binding: EditJoutnalBinding(),
  ),
  GetPage(
    name: Routes.journalRecords,
    page: () {
      final petId = Get.arguments as String;
      return JournalRecordsPage(petId: petId);
    },
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 200),
  ),
];
