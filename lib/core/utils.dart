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

Future<void> showMyDialog(BuildContext context, String error) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error !'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[Text(error)],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
