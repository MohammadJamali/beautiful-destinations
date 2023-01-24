import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final Widget icon;
  final String? text;
  final double size;

  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  final VoidCallback onTap;

  final Color? backgroundColor;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.text,
    this.size = 60,
    this.textStyle,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final Widget buttonContent;
    if (text != null) {
      buttonContent = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          Expanded(
            child: Text(
              text!,
              // minFontSize: 3,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          )
        ],
      );
    } else {
      buttonContent = Center(child: icon);
    }

    final iconButton = Material(
      color: backgroundColor ?? Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox.square(dimension: size, child: buttonContent),
      ),
    );

    if (padding != null) return Padding(padding: padding!, child: iconButton);
    return iconButton;
  }
}
