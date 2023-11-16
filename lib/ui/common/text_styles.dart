import 'package:flutter/material.dart';

abstract class AppTextStyles {

  static const TextStyle appBar = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 26
  );

  static const TextStyle sendButton = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static const TextStyle label = TextStyle(
    color: Color(0xFF838898),
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
}