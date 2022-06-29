import 'package:flutter/material.dart';

class ValidForm {
  ValidForm();

  bool validNombre(v) {
    final _name = RegExp(r"[0-9]+");
    if (_name.hasMatch(v)) {
      return true;
    } else {
      return false;
    }
  }
}
