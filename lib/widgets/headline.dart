import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  const Headline({
    super.key,
    required this.text,
    this.padding = const EdgeInsets.only(
      top: 32.0,
      bottom: 16,
      left: 24,
      right: 24,
    ),
  });

  final String text;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
