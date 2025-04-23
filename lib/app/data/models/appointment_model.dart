import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pet_model.dart';

import '../../../core/controller/pet_controller.dart';

class Appointment {
  final String appointmentId;
  Service service;
  String details;
  List<String> petIds;
  DateTime appointedAt;
  Appointment({
    required this.appointmentId,
    required this.service,
    required this.details,
    required this.petIds,
    required this.appointedAt,
  });

  factory Appointment.fromJson(
    String appointmentId,
    Map<String, dynamic> jsonMap,
  ) {
    final Map<String, Pet> petMap = Map.from(Get.find<PetController>().petMap);
    petMap.removeWhere(
      (key, value) => !jsonMap['pet_ids'].contains(value.petId),
    );
    final petIds = petMap.values.map((pet) => pet.petId).toList();

    final service = Service.values.firstWhere(
      (service) => service.text == jsonMap['service'],
    );

    return Appointment(
      appointmentId: appointmentId,
      service: service,
      details: jsonMap['details'],
      petIds: petIds,
      appointedAt: jsonMap['appointed_at'].toDate(),
    );
  }

  static Map<String, dynamic> toJson(Appointment appointment) {
    final appointmentMap = {
      'service': appointment.service.text,
      'details': appointment.details,
      'pet_ids': appointment.petIds,
      'appointed_at': appointment.appointedAt,
    };
    return appointmentMap;
  }
}

enum Service {
  vaccination('Vaccination', Color(0xFFFFE57F), Icons.vaccines_outlined),
  grooming('Grooming', Color(0xFFB3E5FC), Icons.shower_outlined);

  final String text;
  final Color color;
  final IconData icon;

  const Service(this.text, this.color, this.icon);
}
