import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  // Create a modern looking input field
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: myDarkGreen, width: 2.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
);

final textColor = TextStyle(color: Colors.grey[700]);

const myDarkGreen = Color(0xFF1B8C5C);
const myPastelGreen = Color(0xFF315c4e);
const myGreen = Color(0xFF23cc8c);
const myLightGreen = Color(0xFF80e4c4);
