import 'package:flutter/material.dart';

/// Build an alert to show to the user for exception handling.
///
/// Show a human readable [message] to the user while printing the actual
/// [exception] to console which can be accessed with "flutter logs" command.
class ExceptionAlert {
  static const _alertButtonText = "Cancel";

  static void alert({
    required BuildContext context,
    required String title,
    required String message,
    Exception? exception,
  }) {
    if (exception != null) debugPrint("$title: $exception");

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(_alertButtonText),
          )
        ],
      ),
    );
  }
}
