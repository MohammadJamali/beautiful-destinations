import 'package:beautiful_destinations/app/authentication/bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

class SingInButton extends StatelessWidget {
  const SingInButton({
    super.key,
    required this.onSingInWithEmailAndPasswordPressed,
    required this.onSingInWithEmailLinkPressed,
  });

  final AsyncCallback onSingInWithEmailAndPasswordPressed;
  final AsyncCallback onSingInWithEmailLinkPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) =>
          current.status != previous.status ||
          current.password != previous.password,
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: ElevatedButton(
          onPressed: !state.status.isInvalid ||
                  (state.status.isSubmissionFailure ||
                      state.status.isSubmissionCanceled)
              ? state.password.value.isEmpty
                  ? onSingInWithEmailLinkPressed
                  : onSingInWithEmailAndPasswordPressed
              : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          child: Text(
            state.password.value.isEmpty
                ? localizations.passwordlessSingin
                : localizations.signin,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
