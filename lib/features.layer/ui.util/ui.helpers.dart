import 'package:flutter/material.dart';

extension ShowSnackBarView on BuildContext {
  showSnackBarView(String data) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(data),
    ));
  }
}
