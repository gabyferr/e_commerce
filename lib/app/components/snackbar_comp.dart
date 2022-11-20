import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class SnackbarComp {
  static build(BuildContext context, String titleText, String messageText) {
    AnimatedSnackBar.rectangle(
      titleText,
      messageText,
      type: AnimatedSnackBarType.error,
      brightness: Brightness.light,
    ).show(
      context,
    );
  }
}
