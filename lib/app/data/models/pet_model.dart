import 'package:flutter/material.dart';

enum Gender {
  none('None', Colors.black, Icons.question_mark),
  male('Male', Color(0xFF1565C0), Icons.male),
  female('Female', Color(0xFFF576AC), Icons.female);

  final String text;
  final Color color;
  final IconData icon;

  const Gender(this.text, this.color, this.icon);
}

class Pet {
  final String ownerId;
  final String? petId;
  String petType;
  String petName;
  String breedName;
  Gender gender;
  double? weight;
  String color;
  DateTime? birthday;
  String age;
  String story;
  String imageUrl;
  String imageId;
  Pet({
    required this.ownerId,
    required this.petId,
    required this.petType,
    required this.petName,
    this.breedName = '',
    this.gender = Gender.none,
    this.weight,
    this.color = '',
    this.birthday,
    this.age = '',
    this.story = '',
    this.imageUrl = '',
    this.imageId = '',
  });

  factory Pet.fromJson(String petId, Map<String, dynamic> jsonMap) {
    final gender = Gender.values.firstWhere(
      (gender) => gender.text == jsonMap['gender'],
    );
    final age = calculateAge(jsonMap['birthday']?.toDate());
    return Pet(
      ownerId: jsonMap['owner_id'],
      petId: petId,
      petType: jsonMap['pet_type'],
      petName: jsonMap['pet_name'],
      breedName: jsonMap['breed_name'] ?? '',
      gender: gender,
      weight: jsonMap['weight'],
      color: jsonMap['color'] ?? '',
      birthday: jsonMap['birthday']?.toDate(),
      age: age,
      story: jsonMap['story'] ?? '',
      imageUrl: jsonMap['image_url'] ?? '',
      imageId: jsonMap['image_id'] ?? '',
    );
  }

  static Map<String, dynamic> toJson(Pet pet) {
    Map<String, dynamic> petMap = {
      'owner_id': pet.ownerId,
      'pet_type': pet.petType,
      'pet_name': pet.petName,
      'breed_name': pet.breedName,
      'gender': pet.gender.text,
      'weight': pet.weight,
      'color': pet.color,
      'birthday': pet.birthday,
      'story': pet.story,
      'image_url': pet.imageUrl,
      'image_id': pet.imageId,
    };
    return petMap;
  }

  static String calculateAge(DateTime? birthday) {
    if (birthday == null) {
      return '';
    }
    final now = DateTime.now();

    int yearDiff = now.year - birthday.year;
    int monthDiff = now.month - birthday.month;
    if (monthDiff < 0) {
      yearDiff -= 1;
      monthDiff += 12;
    }
    return '${yearDiff != 0 ? '${yearDiff}y ' : ''}${monthDiff}m';
  }
}
