import 'package:flutter/material.dart';

class Responsive {
  static double screenSize(dynamic context) {
    return MediaQuery.of(context).size.width;
  }
}
