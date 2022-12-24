import 'dart:math';

import 'package:beautiful_destinations/extensions/number_extention.dart';
import 'package:beautiful_destinations/app/home/home.dart';
import 'package:beautiful_destinations/widgets/count_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthCodeView extends StatefulWidget {
  const AuthCodeView({super.key});

  @override
  State<AuthCodeView> createState() => _AuthCodeViewState();
}

class _AuthCodeViewState extends State<AuthCodeView> {
  late List<BoxDecoration> codeBoxDecorations;
  late final BoxDecoration normalBoxDecoration;
  late final BoxDecoration errorBoxDecoration;
  late final BoxDecoration successBoxDecoration;

  late AppLocalizations localizations;
  late CountDownWidget countDownWidget;
  late ThemeData theme;

  late List<int?> code;
  late int codeIndex;
  bool resendActive = false;

  BoxDecoration _boxDecoration(MaterialColor color) => BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.shade300),
        color: color.shade100,
      );

  void reset() {
    code = List.generate(4, (index) => null);
    codeIndex = 0;
  }

  Widget onCountDown(int count, BuildContext context) => Text(
        localizations.otp.replaceFirst('{0}', count.secondsToMmSs()),
        style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
      );

  Future<void> onCountDownFinished() async =>
      setState(() => resendActive = true);

  @override
  void initState() {
    normalBoxDecoration = _boxDecoration(Colors.grey);
    errorBoxDecoration = _boxDecoration(Colors.red);
    successBoxDecoration = _boxDecoration(Colors.green);

    codeBoxDecorations = List.generate(4, (index) => normalBoxDecoration);
    countDownWidget = CountDownWidget(
      key: UniqueKey(),
      seconds: 3,
      onCountDown: onCountDown,
      onFinished: onCountDownFinished,
    );
    reset();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
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
      const Duration(seconds: 2),
      () {
        Navigator.pop(context);
      },
    );
  }

  Future<void> onKeyPressed(int number) async {
    setState(() {
      code[codeIndex] = number;
      codeIndex = min(3, codeIndex + 1);
    });

    if (codeIndex == 3 && code[3] != null) {
      await onCodeComplated();
    }
  }

  bool fail = false;
  Future<void> onCodeComplated() async {
    if (!fail) {
      await onError();
      fail = true;
    } else {
      await onSuccess();
    }
  }

  void onBackspacePressed() {
    setState(() {
      code[codeIndex] = null;
      codeIndex = max(0, codeIndex - 1);
    });
  }

  Future<void> onError() async {
    final scaffold = ScaffoldMessenger.of(context);
    await fakeSingin();
    scaffold.showSnackBar(SnackBar(content: Text(localizations.invalidOtp)));

    for (var i = 0; i < 4; i++) {
      setState(() {
        if (i > 0) {
          codeBoxDecorations[i - 1] = normalBoxDecoration;
        }
        codeBoxDecorations[i] = errorBoxDecoration;
      });
      await Future.delayed(const Duration(milliseconds: 200));
    }
    setState(() {
      codeBoxDecorations[3] = normalBoxDecoration;
      codeIndex = 0;
      code = List.generate(4, (index) => null);
    });
  }

  Future<void> onSuccess() async {
    final navigator = Navigator.of(context);
    await fakeSingin();
    for (var i = 0; i < 4; i++) {
      setState(() {
        codeBoxDecorations[i] = successBoxDecoration;
      });
      await Future.delayed(const Duration(milliseconds: 200));
    }

    await Future.delayed(const Duration(milliseconds: 500));
    navigator.pushNamedAndRemoveUntil(
      MainView.routeName,
      ModalRoute.withName('/'),
    );
  }

  Future<void> onResendPressed() async {
    final scaffold = ScaffoldMessenger.of(context);
    await fakeSingin();
    scaffold.showSnackBar(SnackBar(content: Text(localizations.otpResent)));

    setState(() {
      countDownWidget = CountDownWidget(
        key: UniqueKey(),
        seconds: 120,
        onCountDown: onCountDown,
        onFinished: onCountDownFinished,
      );
      resendActive = false;
    });
  }

  Widget _numpadButtonString(
    String text,
    VoidCallback onTap,
  ) =>
      _numpadButton(
        Text(
          text,
          style: theme.textTheme.headline5?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap,
      );

  Widget _numpadButton(
    Widget text,
    VoidCallback onTap,
  ) =>
      InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          width: 64,
          height: 64,
          alignment: Alignment.center,
          child: text,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.fingerprint_rounded,
                          size: 64,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            localizations.authentication,
                            style: theme.textTheme.headline5,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 16,
                      bottom: 8,
                    ),
                    child: countDownWidget,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: index != 0
                              ? const EdgeInsetsDirectional.only(start: 16)
                              : null,
                          decoration: codeBoxDecorations[index],
                          width: 64,
                          height: 64,
                          alignment: Alignment.center,
                          child: AnimatedCrossFade(
                            crossFadeState: code[index] == null
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 300),
                            firstChild: Icon(
                              Icons.lock_outlined,
                              color: Colors.grey.shade200,
                            ),
                            secondChild: Text(
                              '${code[index]}',
                              style: theme.textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (resendActive)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                      child: Center(
                        child: TextButton(
                          onPressed: onResendPressed,
                          child: Text(
                            localizations.resendCode,
                            style: theme.textTheme.button?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  for (var row = 0; row < 3; row++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          3,
                          (index) => _numpadButtonString(
                            '${index + (row * 3) + 1}',
                            () => onKeyPressed(index + (row * 3) + 1),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox.square(dimension: 64),
                        _numpadButtonString(
                          '0',
                          () => onKeyPressed(0),
                        ),
                        _numpadButton(
                          const Icon(
                            Icons.backspace,
                            size: 24,
                          ),
                          onBackspacePressed,
                        ),
                      ],
                    ),
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
