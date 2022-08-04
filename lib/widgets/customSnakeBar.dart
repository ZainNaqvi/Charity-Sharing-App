import 'package:flutter/material.dart';

showSnakeBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'X',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      duration: const Duration(
        seconds: 3,
      ),
      backgroundColor: const Color(0xff023020),
    ),
  );
}
