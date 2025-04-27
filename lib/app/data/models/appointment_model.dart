import 'package:flutter/material.dart';

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
    final service = Service.values.firstWhere(
      (service) => service.text == jsonMap['service'],
    );

    return Appointment(
      appointmentId: appointmentId,
      service: service,
      details: jsonMap['details'] ?? '',
      petIds: (jsonMap['pet_ids'] as List).cast<String>(),
      appointedAt: jsonMap['appointed_at'].toDate(),
    );
  }

  static Map<String, dynamic> toJson(Appointment appointment) {
    final Map<String, dynamic> appointmentMap = {
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
