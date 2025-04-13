import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
  static final _backgroundColor = Get.theme.colorScheme.onPrimary;
  static final _boxShadow = BoxShadow(
    color: Get.theme.colorScheme.secondary,
    blurRadius: 8,
  );
  static final _duration = const Duration(seconds: 5);

  static void showSuccess(String message, {String title = 'Success 🐾'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: _backgroundColor,
      boxShadows: [_boxShadow],
      icon: Icon(Icons.check_circle_outline, color: Get.theme.primaryColor),
      duration: _duration,
    );
  }

  static void showError({
    String message = 'Something went wrong. Please try again.',
    String title = 'Woof! 🐶',
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: _backgroundColor,
      boxShadows: [_boxShadow],
      icon: Icon(Icons.error_outline, color: Get.theme.colorScheme.error),
      duration: _duration,
    );
  }

  static void showInfo(String message, {String title = 'Heads up 🐶'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: _backgroundColor,
      boxShadows: [_boxShadow],
      icon: Icon(Icons.info_outline, color: Get.theme.colorScheme.onSecondary),
      duration: _duration,
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

  static void showEditSuccess() {
    showSuccess(
      'The changes have been saved successfully.',
      title: 'All set! 🐾',
    );
  }

  static void showEditError() {
    showError(message: 'Something went wrong while saving your changes.');
  }

  static void showAddPetSuccess() {
    showSuccess('Your pet has been added successfully! 🐕', title: 'Success!');
  }

  static void showAddPetError() {
    showError(message: 'Something went wrong while saving your pet.');
  }

  static void showWelcomeBack(String username, [int numberOfPets = 1]) {
    showInfo(
      'Your pet${numberOfPets == 1 ? '' : 's'} missed you 🐶',
      title: 'Welcome back, $username!',
    );
  }
}
