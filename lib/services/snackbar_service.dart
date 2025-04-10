import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
  static final _backgroundColor = Get.theme.primaryColor.withAlpha(160);
  static final _duration = const Duration(seconds: 4);

  static void showSuccess(String message, {String title = 'Success 🐾'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: _backgroundColor,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      duration: _duration,
    );
  }

  static void showError(String message, {String title = 'Woof! 🐶'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: _backgroundColor,
      icon: const Icon(Icons.error_outline, color: Colors.white),
      duration: _duration,
    );
  }

  static void showInfo(String message, {String title = 'Heads up 🐶'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: _backgroundColor,
      icon: const Icon(Icons.info_outline, color: Colors.white),
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
        default:
          message = 'An unexpected error occurred.';
          break;
      }
    } catch (e) {
      message = 'Something went wrong. Please try again.';
    }
    showError('Registration failed: $message', title: 'Oops! 🐶');
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
        case 'invalid-credential':
          message = 'Invalid email or password.';
          break;
        case 'invalid-email':
          message = 'The email address is badly formatted.';
          break;
        case 'user-not-found':
          message = 'No account found for that email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password. Please try again.';
          break;
        case 'user-disabled':
          message = 'This account has been disabled.';
          break;
        case 'too-many-requests':
          message = 'Too many login attempts. Please wait and try again.';
          break;
        default:
          message = 'An unexpected error occurred.';
          break;
      }
    } catch (e) {
      message = 'Something went wrong. Please try again.';
    }
    showError('Login failed: $message');
  }

  static void showEditSuccess() {
    showSuccess(
      'The changes have been saved successfully.',
      title: 'All set! 🐾',
    );
  }

  static void showEditError() {
    showError('Something went wrong while saving your changes.');
  }

  static void showWelcomeBack(String username) {
    showInfo('Your pet(s) missed you 🐶', title: 'Welcome back, $username!');
  }

  static void showPetAdded() {
    showSuccess('Your pet has been added successfully! 🐕');
  }
}
