import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_2/generated/l10n.dart';


class ErrorHandler {
  static String handleException(BuildContext context, dynamic e) {
    final localizations = AppLocalizations.of(context)!;
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return localizations.errorUserNotFound;
        case 'wrong-password':
          return localizations.errorWrongPassword;
        case 'email-already-in-use':
          return localizations.errorEmailInUse;
        case 'invalid-email':
          return localizations.errorInvalidEmail;
        default:
          return e.message ?? localizations.errorAuthGeneric;
      }
    } else if (e is Exception) {
      return e.toString().replaceFirst('Exception: ', '');
    }
    return localizations.errorGeneric(e.toString());
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}