import 'dart:io';

import 'package:beautiful_destinations/app/authentication/bloc/login/login_bloc.dart';
import 'package:beautiful_destinations/app/authentication/view/auth_code.dart';
import 'package:beautiful_destinations/app/authentication/widgets/form/email/input.dart';
import 'package:beautiful_destinations/app/authentication/widgets/form/password/input.dart';
import 'package:beautiful_destinations/app/authentication/widgets/outline_icon_button.dart';
import 'package:beautiful_destinations/app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

class LoginView extends StatefulWidget {
  static const routeName = '/auth/signup';

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

  Future<void> onSinginPressed() async {
    final navigator = Navigator.of(context);
    await fakeSingin();
    navigator.pushNamed(AuthCodeView.routeName);
  }

  void onSkipPressed() {
    Navigator.of(context).popAndPushNamed(MainView.routeName);
  }

  Future<void> onGoogleLoginPressed() async {
    await context.read<LoginCubit>().signInWithGoogle();
  }

  Future<void> onAppleLoginPressed() async {
    final navigator = Navigator.of(context);
    await fakeSingin();
    navigator.popAndPushNamed(MainView.routeName);
  }

  Future<void> onFacebookLoginPressed() async {
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
                onPressed: onAppleLoginPressed,
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
                onPressed: onGoogleLoginPressed,
              ),
            ),
          const SizedBox.square(dimension: 16),
          Flexible(
            flex: 1,
            child: OutlineIconButton(
              icon: const Icon(Icons.facebook, color: Colors.blue),
              label: localizations.facebook,
              onPressed: onFacebookLoginPressed,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
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
        },
        child: SafeArea(
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
                          children: const [
                            EmailInput(),
                            Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: PasswordInput(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: ElevatedButton(
                            onPressed: onSinginPressed,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            child: Text(
                              localizations.signin,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  localizations.or,
                                  style: theme.textTheme.bodyText1?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),
                        ),
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
      ),
    );
  }
}
