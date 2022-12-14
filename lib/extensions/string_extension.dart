import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension StringExtension on String {
  void showSnackBar(
    BuildContext context, {
    SnackBarAction? action,
    VoidCallback? onVisible,
    DismissDirection dismissDirection = DismissDirection.down,
    behavior = SnackBarBehavior.floating,
    duration = const Duration(seconds: 10),
  }) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 6.0,
          width: 400,
          dismissDirection: DismissDirection.down,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 10),
          content: Text(this),
        ),
      );
    } catch (_) {}
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: this));
  }
}
