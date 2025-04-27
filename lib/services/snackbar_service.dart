import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
  static final _duration = const Duration(seconds: 4);
  static final _backgroundColor = Get.theme.colorScheme.onPrimary;
  static final _boxShadow = BoxShadow(
    color: Get.theme.colorScheme.secondary,
    blurRadius: 8,
  );

  static void showSuccess(
    String message, {
    String title = 'Success 🐾',
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: _backgroundColor,
      boxShadows: [_boxShadow],
      icon: Icon(Icons.check_circle_outline, color: Get.theme.primaryColor),
      duration: _duration,
      snackPosition: snackPosition,
    );
  }

  static void showError({
    String message = 'Something went wrong. Please try again.',
    String title = 'Woof! 🐶',
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: _backgroundColor,
      boxShadows: [_boxShadow],
      icon: Icon(Icons.error_outline, color: Get.theme.colorScheme.error),
      duration: _duration,
      snackPosition: snackPosition,
    );
  }

  static void showInfo(
    String message, {
    String title = 'Heads up 🐶',
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: _backgroundColor,
      boxShadows: [_boxShadow],
      icon: Icon(Icons.info_outline, color: Get.theme.colorScheme.onSecondary),
      duration: _duration,
      snackPosition: snackPosition,
    );
  }

  static void showRegisterSuccess() {
    showSuccess('Your registration was successful 🐾', title: 'Welcome!');
  }

  static void showRegisterError(Object error) {
    String message = '';
    try {
      throw error;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          message = 'This email is already registered.';
          break;
        case 'invalid-email':
          message = 'The email address is invalid.';
          break;
        case 'weak-password':
          message = 'The password is too weak. Please use a stronger one.';
          break;
        case 'operation-not-allowed':
          message = 'This operation is not allowed.';
          break;
        case 'too-many-requests':
          message = 'Too many requests. Please wait and try again.';
          break;
        default:
          message = 'An unexpected error occurred.';
          break;
      }
    } catch (e) {
      message = 'Something went wrong. Please try again.';
    }
    showError(message: 'Registration failed: $message', title: 'Oops! 🐶');
  }

  static void showLoginSuccess() {
    showSuccess("Login successful! Let's care together.");
  }

  static void showLoginError(Object error) {
    String message = '';
    try {
      throw error;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'too-many-requests':
          message = 'Too many login attempts. Please wait and try again.';
          break;
        default:
          message = 'Email or password is incorrect. Please try again.';
      }
    } catch (e) {
      message = 'Something went wrong. Please try again.';
    }
    showError(message: 'Login failed: $message');
  }

  static void showDeleteSuccess(String label) {
    showSuccess(
      'The ${label.toLowerCase()} has been deleted successfully.',
      title: '$label removed',
    );
  }

  static void showDeleteError() {
    showError(message: 'Something went wrong while deleting');
  }

  static void showAddPetSuccess() {
    showSuccess('Your pet has been added successfully! 🐕', title: 'Success!');
  }

  static void showAddPetError() {
    showError(message: 'Something went wrong while saving your pet.');
  }

  static void showAddAppointmentSuccess() {
    showSuccess(
      'Your appointment has been successfully scheduled.',
      title: 'Appointment Confirmed 🐾',
    );
  }

  static void showAddAppointmentError() {
    showError(
      message: 'We couldn’t schedule your appointment. Please try again.',
    );
  }

  static void showMarkAppointmentSuccess() {
    showSuccess(
      'This appointment has been marked as completed.',
      title: 'Appointment Completed',
    );
  }

  static void showMarkAppointmentError() {
    showError(message: 'We couldn’t mark your appointment. Please try again.');
  }

  static void showAddJournalSuccess() {
    showSuccess('Journal added successfully! ✨');
  }

  static void showAddJournalError() {
    showError(message: "Something went wrong. Couldn't save your journal. 🐾");
  }

  static void showEditSuccess({
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    showSuccess(
      'The changes have been saved successfully.',
      title: 'All set! 🐾',
      snackPosition: snackPosition,
    );
  }

  static void showEditError() {
    showError(message: 'Something went wrong while saving your changes.');
  }

  static void showWelcomeBack(String username, int numberOfPets) {
    final title = 'Welcome back, $username!';
    if (numberOfPets == 0) {
      showInfo("Let's add your first furry friend 🐶", title: title);
    } else {
      showInfo(
        'Your pet${numberOfPets == 1 ? '' : 's'} missed you 🐶',
        title: title,
      );
    }
  }
}
