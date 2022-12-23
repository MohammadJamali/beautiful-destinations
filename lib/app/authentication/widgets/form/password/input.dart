import 'package:beautiful_destinations/app/authentication/bloc/login/login_bloc.dart';
import 'package:beautiful_destinations/widgets/icon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.password ?? 'Password',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: IconTextField.sizedIcon(
                textFieldKey: const Key('loginForm_passwordInput_textField'),
                icon: Icons.lock_outline_rounded,
                hint: 'password',
                obscureText: true,
                backgroundColor: Colors.grey.shade100,
                backgroundFocusColor: theme.primaryColor.withOpacity(0.02),
                deactiveColor: Colors.grey.shade300,
                focusColor: theme.primaryColor.withOpacity(0.5),
                onChanged: (password) =>
                    context.read<LoginCubit>().passwordChanged(password),
                errorText: state.password.invalid ? 'invalid password' : null,
              ),
            )
          ],
        );
      },
    );
  }
}
