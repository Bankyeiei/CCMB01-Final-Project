import 'package:get/get.dart';

import 'pet_model.dart';

import '../../../core/controller/pet_controller.dart';

class Appointment {
  final String? appointmentId;
  final String serviceType;
  final String details;
  final List<Pet> pets;
  final DateTime appointedAt;
  Appointment({
    required this.appointmentId,
    required this.serviceType,
    required this.details,
    required this.pets,
    required this.appointedAt,
  });

  factory Appointment.fromJson(
    String appointmentId,
    Map<String, dynamic> jsonMap,
  ) {
    final Map<String, Pet> petMap = Map.from(Get.find<PetController>().petMap);
    petMap.removeWhere((key, value) => !jsonMap['pets'].contains(value.petId));

    return Appointment(
      appointmentId: appointmentId,
      serviceType: jsonMap['service_type'],
      details: jsonMap['details'],
      pets: petMap.values.toList(),
      appointedAt: jsonMap['appointed_at'].toDate(),
    );
  }

  static Map<String, dynamic> toJson(Appointment appointment) {
    final petList = appointment.pets.map((pet) => pet.petId).toList();
    petList.sort();

    final appointmentMap = {
      'service_type': appointment.serviceType,
      'details': appointment.details,
      'pets': petList,
      'appointed_at': appointment.appointedAt,
    };
    return appointmentMap;
  }
}
