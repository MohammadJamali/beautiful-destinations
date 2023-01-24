import 'dart:math';

import 'package:beautiful_destinations/app/authentication/authentication.dart';
import 'package:beautiful_destinations/app/authentication/bloc/bloc.dart';
import 'package:beautiful_destinations/app/navigation/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  Future<void> sendVerficationCode(BuildContext context, String email) async {
    await context.read<SignInCubit>().sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.read<SettingsBloc>().state.user;

    final mediaQuery = MediaQuery.of(context);
    final localizations = AppLocalizations.of(context)!;
    final buttonSize = Size(min(300, mediaQuery.size.width * 0.8), 60);

    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        } else if (state.status.isSubmissionSuccess) {
          Navigator.of(context).popAndPushNamed(AuthCodePage.routeName);
        }
      },
      child: Stack(
        children: [
          SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: Icon(
                            Icons.mark_email_read_rounded,
                            size: 100,
                            color: theme.primaryColor,
                          ),
                        ),
                        Text(
                          localizations.verifyEmail,
                          style: theme.textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 128),
                          child: Text(
                            localizations.verifyEmailInfo.replaceFirst(
                              '{0}',
                              user.email!,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.fade,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () => sendVerficationCode(context, user.email!),
                    style: ElevatedButton.styleFrom(
                      minimumSize: buttonSize,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Text(
                      localizations.sendVerificationCode,
                      style: theme.textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<SignInCubit, SignInState>(
            buildWhen: (previous, current) => current.status != previous.status,
            builder: (context, state) => state.status.isSubmissionInProgress
                ? Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
