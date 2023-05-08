import 'dart:ui';

import 'package:flutter/material.dart';

class FormStyles {
  static InputDecoration inputDecoration({required String label}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    );
  }

  static TextStyle inputTextStyle() {
    return TextStyle(fontSize: 16, color: Colors.white);
  }
}

InputDecoration buildInputDecoration(String labelText, String hintText) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white54),
    labelStyle: TextStyle(color: Colors.white),
    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade300,
        width: 1,
      ),
      borderRadius: BorderRadius.horizontal(
          left: Radius.circular(8), right: Radius.circular(8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF4B39EF),
        width: 2,
      ),
      borderRadius: BorderRadius.horizontal(
          left: Radius.circular(8), right: Radius.circular(8)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 1,
      ),
      borderRadius: BorderRadius.horizontal(
          left: Radius.circular(8), right: Radius.circular(8)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 2,
      ),
      borderRadius: BorderRadius.horizontal(
          left: Radius.circular(8), right: Radius.circular(8)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade300,
        width: 1,
      ),
      borderRadius: BorderRadius.horizontal(
          left: Radius.circular(8), right: Radius.circular(8)),
    ),
  );
}

BoxDecoration buildContainerDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
    ],
  );
}
