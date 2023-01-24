import 'package:beautiful_destinations/app/authentication/bloc/bloc.dart';
import 'package:beautiful_destinations/widgets/icon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFormInput extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hint;
  final bool Function(SignInState, SignInState) buildWhen;
  final Key textFieldKey;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String, BuildContext, SignInState) onChanged;
  final String? Function(BuildContext, SignInState) getError;

  const TextFormInput({
    super.key,
    required this.label,
    required this.hint,
    required this.buildWhen,
    required this.textFieldKey,
    required this.keyboardType,
    required this.obscureText,
    required this.onChanged,
    required this.getError,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: buildWhen,
      builder: (context, state) {
        final error = getError(context, state);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: IconTextField.sizedIcon(
                textFieldKey: textFieldKey,
                icon: icon,
                hint: hint,
                keyboardType: keyboardType,
                obscureText: obscureText,
                backgroundColor: Colors.grey.shade100,
                backgroundFocusColor: theme.primaryColor.withOpacity(0.02),
                deactiveColor: Colors.grey.shade300,
                focusColor: theme.primaryColor.withOpacity(0.5),
                onChanged: (value) => onChanged(value, context, state),
              ),
            ),
            AnimatedCrossFade(
              crossFadeState: error != null
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 200),
              firstChild: Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 8.0,
                  start: 64.0,
                ),
                child: Text(
                  error ?? '',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.errorColor,
                  ),
                ),
              ),
              secondChild: const SizedBox(),
            )
          ],
        );
      },
    );
  }
}
