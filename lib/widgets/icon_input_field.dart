import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IconTextFormField extends StatefulWidget {
  final AsyncCallback? iconCallback;
  final Widget icon;
  final String? hint;

  final double dividerIntent;
  final double height;

  final bool obscureText;

  final Color? backgroundColor;
  final Color? backgroundFocusColor;
  final Color deactiveColor;
  final Color focusColor;

  final TextInputType? keyboardType;

  const IconTextFormField({
    super.key,
    required this.icon,
    required this.deactiveColor,
    required this.focusColor,
    this.keyboardType,
    this.backgroundColor,
    this.backgroundFocusColor,
    this.obscureText = false,
    this.iconCallback,
    this.height = 50,
    this.dividerIntent = 0,
    this.hint,
  });

  IconTextFormField.sizedIcon({
    super.key,
    required IconData icon,
    required this.deactiveColor,
    required this.focusColor,
    this.keyboardType,
    this.backgroundColor,
    this.backgroundFocusColor,
    this.obscureText = false,
    this.iconCallback,
    this.height = 50,
    this.dividerIntent = 0,
    this.hint,
  }) : icon = SizedBox(
          height: height,
          width: 60,
          child: Icon(
            icon,
            color: Colors.grey.shade600,
          ),
        );

  @override
  State<IconTextFormField> createState() => _IconTextFormFieldState();
}

class _IconTextFormFieldState extends State<IconTextFormField> {
  final FocusNode focusNode = FocusNode();

  bool hasFocus = false;

  @override
  void initState() {
    focusNode.addListener(onfocusChanged);
    super.initState();
  }

  void onfocusChanged() {
    setState(() {
      hasFocus = focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(
          color: hasFocus ? widget.focusColor : widget.deactiveColor,
        ),
        borderRadius: BorderRadius.circular(32),
        color: hasFocus
            ? widget.backgroundFocusColor ?? widget.backgroundColor
            : widget.backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: widget.iconCallback,
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(32),
              bottomStart: Radius.circular(32),
            ).resolve(Directionality.of(context)),
            child: IconTheme.merge(
                data: IconThemeData(
                  color: hasFocus ? widget.focusColor : null,
                ),
                child: widget.icon),
          ),
          VerticalDivider(
            color: hasFocus ? widget.focusColor : widget.deactiveColor,
            thickness: 0.5,
            width: 0,
            indent: widget.dividerIntent,
            endIndent: widget.dividerIntent,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                focusNode: focusNode,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
