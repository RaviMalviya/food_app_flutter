import 'package:flutter/material.dart';

extension ShowSnackBarView on BuildContext {
  showSnackBarView(String data) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      key: const ValueKey('My App SnackBar Key'),
      content: Text(data),
    ));
  }
}
