import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  text = text[0].toUpperCase() + text.substring(1);
  text = text.replaceAll('-', ' ');
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ],
        );
      });
}
