import 'package:beautiful_destinations/app/authentication/bloc/bloc.dart';
import 'package:beautiful_destinations/app/authentication/view/singin.dart';
import 'package:beautiful_destinations/repositories/authentication/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingInPage extends StatelessWidget {
  static const routeName = '/auth/signup';

  const SingInPage({super.key});

  static Page<void> page() => const MaterialPage(child: SingInPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignInCubit>(
        create: (_) => SignInCubit(
          context.read<AuthenticationRepository>(),
          AppLocalizations.of(context)!,
        ),
        child: const LoginView(),
      ),
    );
  }
}
