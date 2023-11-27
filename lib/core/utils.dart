import 'package:flutter/material.dart';

Future<void> showDialogFunction(
    BuildContext context, String text, Object error) async {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(error.toString()),
          ));
}

void showSnackBar(BuildContext context, String text, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: color,
  ));
}
