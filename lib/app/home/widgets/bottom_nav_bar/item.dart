import 'package:flutter/material.dart';

class FloatingBottomNavbarItem {
  final IconData icon;
  final String? text;
  final double height;
  final double width;
  final Color? selectedColor;
  final Color? unselectedColor;

  final VoidCallback? onActionCallback;

  const FloatingBottomNavbarItem({
    required this.icon,
    this.text,
    this.height = 60,
    this.width = 60,
    this.selectedColor,
    this.unselectedColor,
    this.onActionCallback,
  });
}

class FloatingBottomNavbarAction {
  final Widget child;
  final VoidCallback onTap;

  const FloatingBottomNavbarAction({
    required this.child,
    required this.onTap,
  });
}
