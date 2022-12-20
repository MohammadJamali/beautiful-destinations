import 'dart:io';

import 'package:beautiful_destinations/app/authentication/code.dart';
import 'package:beautiful_destinations/app/home/home.dart';
import 'package:beautiful_destinations/widgets/icon_input_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  Widget outlineIconButton(Widget icon, String label, AsyncCallback callback) {
    return OutlinedButton.icon(
      onPressed: callback,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      icon: icon,
      label: Text(
        label,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  Widget _formField({
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
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
          child: IconTextFormField.sizedIcon(
            icon: icon,
            hint: hint,
            keyboardType: keyboardType,
            obscureText: obscureText,
            backgroundColor: Colors.grey.shade100,
            backgroundFocusColor: theme.primaryColor.withOpacity(0.02),
            deactiveColor: Colors.grey.shade300,
            focusColor: theme.primaryColor.withOpacity(0.5),
          ),
        )
      ],
    );
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

  Future<void> onGooglePressed() async {
    final navigator = Navigator.of(context);
    await fakeSingin();
    navigator.popAndPushNamed(MainView.routeName);
  }

  Future<void> onApplePressed() async {
    final navigator = Navigator.of(context);
    await fakeSingin();
    navigator.popAndPushNamed(MainView.routeName);
  }

  Future<void> onFacebookPressed() async {
    final navigator = Navigator.of(context);
    await fakeSingin();
    navigator.popAndPushNamed(MainView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        padding: const EdgeInsets.only(top: 24.0, bottom: 64.0),
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
                          _formField(
                            label: localizations.email,
                            hint: 'exmaple@email.com',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: _formField(
                              label: localizations.password,
                              hint: 'password',
                              obscureText: true,
                              icon: Icons.lock_outline_rounded,
                            ),
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
                      Row(
                        children: [
                          if (Platform.isIOS)
                            Flexible(
                              flex: 1,
                              child: outlineIconButton(
                                const Icon(
                                  Icons.apple_outlined,
                                  size: 32,
                                  color: Colors.black,
                                ),
                                localizations.apple,
                                onGooglePressed,
                              ),
                            ),
                          if (Platform.isAndroid)
                            Flexible(
                              flex: 1,
                              child: outlineIconButton(
                                const Icon(
                                  Icons.g_mobiledata_outlined,
                                  size: 32,
                                  color: Colors.orange,
                                ),
                                localizations.google,
                                onGooglePressed,
                              ),
                            ),
                          const SizedBox.square(dimension: 16),
                          Flexible(
                            flex: 1,
                            child: outlineIconButton(
                              const Icon(Icons.facebook, color: Colors.blue),
                              localizations.facebook,
                              onFacebookPressed,
                            ),
                          ),
                        ],
                      ),
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
    );
  }
}
