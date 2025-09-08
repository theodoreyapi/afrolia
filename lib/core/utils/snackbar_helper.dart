import 'package:flutter/material.dart';

import '../themes/themes.dart';

class SnackbarHelper {
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        action: SnackBarAction(
          textColor: appColorBlack,
          label: 'Fermer',
          onPressed: () {
            // Code to execute.
          },
        ),
        content: Text(message),
        duration: const Duration(milliseconds: 5000),
        // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        action: SnackBarAction(
          textColor: appColorBlack,
          label: 'Fermer',
          onPressed: () {
            // Code to execute.
          },
        ),
        content: Text(message),
        duration: const Duration(milliseconds: 5000),
        // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  static void showWarning(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        action: SnackBarAction(
          textColor: appColorBlack,
          label: 'Fermer',
          onPressed: () {
            // Code to execute.
          },
        ),
        content: Text(message),
        duration: const Duration(milliseconds: 5000),
        // width: 280.0,
        // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
