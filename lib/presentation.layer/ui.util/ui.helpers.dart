import 'package:flutter/material.dart';

extension ShowSnackBarView on BuildContext {
  showSnackBarView(String data) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      key: const ValueKey('my_show_snackBar_view'),
      content: Text(data),
    ));
  }
}
