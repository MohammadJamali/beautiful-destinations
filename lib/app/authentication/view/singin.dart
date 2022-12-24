import 'dart:io';

import 'package:beautiful_destinations/app/authentication/authentication.dart';
import 'package:beautiful_destinations/app/authentication/bloc/bloc.dart';
import 'package:beautiful_destinations/app/authentication/view/auth_code.dart';
import 'package:beautiful_destinations/app/authentication/widgets/external_login_devider.dart';
import 'package:beautiful_destinations/app/authentication/widgets/singin_button.dart';

import 'package:beautiful_destinations/app/authentication/widgets/form_inputs/text_input.dart';
import 'package:beautiful_destinations/app/authentication/widgets/outline_icon_button.dart';
import 'package:beautiful_destinations/app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AppLocalizations localizations;
  late MediaQueryData mediaQuery;
  late ThemeData theme;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    mediaQuery = MediaQuery.of(context);
    theme = Theme.of(context);

    super.didChangeDependencies();
  }

  Future<void> fakeSingin() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) => const Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.white,
        ),
      ),
    );
    await Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.pop(context),
    );
  }

  Future<void> onSingInWithEmailLinkPressed() async {
    await context.read<SignInCubit>().sendSignInLinkToEmail();
  }

  Future<void> onSingInWithEmailAndPasswordPressed() async {
    await context.read<SignInCubit>().signInWithCredentials();
  }

  Future<void> onSkipPressed() async {
    await context.read<SignInCubit>().signInAnonymously();
  }

  Future<void> onGoogleSingInPressed() async {
    await context.read<SignInCubit>().signInWithGoogle();
  }

  Future<void> onAppleSingInPressed() async {
    final navigator = Navigator.of(context);
    await fakeSingin();
    navigator.popAndPushNamed(MainView.routeName);
  }

  Future<void> onFacebookSingInPressed() async {
    final navigator = Navigator.of(context);
    await fakeSingin();
    navigator.popAndPushNamed(MainView.routeName);
  }

  Widget _externalLoginButtons() => Row(
        children: [
          if (Platform.isIOS)
            Flexible(
              flex: 1,
              child: OutlineIconButton(
                icon: const Icon(
                  Icons.apple_outlined,
                  size: 32,
                  color: Colors.black,
                ),
                label: localizations.apple,
                onPressed: onAppleSingInPressed,
              ),
            ),
          if (Platform.isAndroid)
            Flexible(
              flex: 1,
              child: OutlineIconButton(
                icon: const Icon(
                  Icons.g_mobiledata_outlined,
                  size: 32,
                  color: Colors.orange,
                ),
                label: localizations.google,
                onPressed: onGoogleSingInPressed,
              ),
            ),
          const SizedBox.square(dimension: 16),
          Flexible(
            flex: 1,
            child: OutlineIconButton(
              icon: const Icon(
                Icons.facebook,
                color: Colors.blue,
              ),
              label: localizations.facebook,
              onPressed: onFacebookSingInPressed,
            ),
          ),
        ],
      );

  Widget _emailInput() => TextFormInput(
        buildWhen: (previous, current) => previous.email != current.email,
        label: localizations.email,
        hint: 'exmaple@email.com',
        textFieldKey: const Key('loginForm_emailInput_textField'),
        keyboardType: TextInputType.emailAddress,
        obscureText: false,
        onChanged: (email, context, state) =>
            context.read<SignInCubit>().emailChanged(email),
        getError: (context, state) =>
            state.email.invalid ? 'invalid email' : null,
        icon: Icons.email_outlined,
      );

  Widget _passwordInput() => TextFormInput(
        buildWhen: (previous, current) => previous.password != current.password,
        label: localizations.password,
        hint: 'password',
        textFieldKey: const Key('loginForm_passwordInput_textField'),
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: (password, context, state) =>
            context.read<SignInCubit>().passwordChanged(password),
        getError: (context, state) =>
            state.password.invalid ? 'invalid password' : null,
        icon: Icons.lock_outline_rounded,
      );

  @override
  Widget build(BuildContext context) {
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
        }

        if (state.status.isSubmissionSuccess) {
          if (state.anonymously || !state.otpSingIn) {
            Navigator.of(context).popAndPushNamed(MainView.routeName);
          } else if (state.otpSingIn) {
            Navigator.of(context).pushNamed(AuthCodePage.routeName);
          }
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                    minHeight: mediaQuery.size.height -
                        mediaQuery.padding.top -
                        mediaQuery.padding.bottom,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.only(top: 24.0, bottom: 64.0),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/images/logo_inline_black.svg',
                              height: 75,
                              semanticsLabel: 'Beautiful Destinations',
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _emailInput(),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: _passwordInput(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SingInButton(
                            onSingInWithEmailLinkPressed:
                                onSingInWithEmailLinkPressed,
                            onSingInWithEmailAndPasswordPressed:
                                onSingInWithEmailAndPasswordPressed,
                          ),
                          const ExternalLoginDivider(),
                          _externalLoginButtons(),
                          Container(
                            padding: const EdgeInsets.only(top: 16.0),
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: onSkipPressed,
                              child: Text(
                                localizations.guestMode,
                                style: theme.textTheme.bodyText1?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
