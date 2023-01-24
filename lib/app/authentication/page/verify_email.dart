import 'package:beautiful_destinations/app/authentication/bloc/signin/signin_bloc.dart';
import 'package:beautiful_destinations/app/authentication/view/verify_email.dart';
import 'package:beautiful_destinations/repositories/authentication/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyEmailPage extends StatelessWidget {
  static const routeName = '/auth/email/verify';
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignInCubit>(
        create: (_) => SignInCubit(
          context.read<AuthenticationRepository>(),
          AppLocalizations.of(context)!,
        ),
        child: const VerifyEmailView(),
      ),
    );
  }
}
