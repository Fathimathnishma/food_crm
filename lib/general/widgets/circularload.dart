import 'package:flutter/material.dart';

class Loading {
  static void addShowDialog(BuildContext context, {String? message}) {
    // Set a default message if none is provided
    final String displayMessage = message ?? 'Loading...';

    Future.delayed(const Duration(seconds: 2), () {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return PopScope(
          canPop: false,
            child: AlertDialog(
              content: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(width: 16),
                  Text(displayMessage),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
