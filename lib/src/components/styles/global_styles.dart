import 'package:flutter/material.dart';

class Styles {
  static TextStyle homepageHeader = const TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.w500,
  );

  static TextStyle primaryHeader = const TextStyle(
    fontSize: 32,
  );

  static TextStyle secondaryHeader = const TextStyle(
    fontSize: 24,
  );

  static TextStyle displayVisits = const TextStyle(
    fontSize: 64,
    color: Colors.white,
  );

  static TextStyle tileVisits = const TextStyle(
    fontSize: 36,
  );

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    fixedSize: const Size.fromWidth(200),
  );
}
