import 'package:beautiful_destinations/app/authentication/bloc/login/login_bloc.dart';
import 'package:beautiful_destinations/widgets/icon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.email ?? 'Email',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: IconTextField.sizedIcon(
                textFieldKey: const Key('loginForm_emailInput_textField'),
                icon: Icons.email_outlined,
                hint: 'exmaple@email.com',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                backgroundColor: Colors.grey.shade100,
                backgroundFocusColor: theme.primaryColor.withOpacity(0.02),
                deactiveColor: Colors.grey.shade300,
                focusColor: theme.primaryColor.withOpacity(0.5),
                onChanged: (email) =>
                    context.read<LoginCubit>().emailChanged(email),
                errorText: state.email.invalid ? 'invalid email' : null,
              ),
            )
          ],
        );
      },
    );
  }
}
