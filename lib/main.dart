import 'dart:io';

import 'package:beautiful_destinations/app/authentication/code.dart';
import 'package:beautiful_destinations/app/authentication/login.dart';
import 'package:beautiful_destinations/app/book/detail.dart';
import 'package:beautiful_destinations/app/home/search/filter.dart';
import 'package:beautiful_destinations/app/tiktok/tiktok_video_view.dart';
import 'package:beautiful_destinations/app/landing/landing.dart';
import 'package:beautiful_destinations/app/home/home.dart';
import 'package:beautiful_destinations/app/navigation_menu/navigation_menu.dart';
import 'package:beautiful_destinations/app/notification/notification.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  if (Platform.isLinux || Platform.isWindows) {
    DartVLC.initialize();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Locale getLocal(String? locale) {
    if (locale != null) return Locale(locale);

    var uriParams = Uri.base.queryParameters;
    if (uriParams.containsKey('lang') &&
        AppLocalizations.supportedLocales.any((supportedLocale) =>
            supportedLocale.languageCode == uriParams['lang'])) {
      return Locale(uriParams['lang']!);
    }

    return const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    const int primaryColor = 0xFFffab40;
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: getLocal('en'),
      routes: {
        LandingView.routeName: (_) => const LandingView(),
        LoginView.routeName: (_) => const LoginView(),
        AuthCodeView.routeName: (_) => const AuthCodeView(),
        MainView.routeName: (_) => const MainView(),
        NotificationView.routeName: (_) => const NotificationView(),
        NavigationMenu.routeName: (_) => const NavigationMenu(),
        FilterView.routeName: (_) => const FilterView(),
        DetailView.routeName: (_) => const DetailView(),
        TiktokVideoView.routeName: (_) => const TiktokVideoView(),
      },
      theme: ThemeData(
        fontFamily: "manrope",
        primarySwatch: const MaterialColor(
          primaryColor,
          <int, Color>{
            50: Color(0xFFFFF5E8),
            100: Color(0xFFFFE6C6),
            200: Color(0xFFFFD5A0),
            300: Color(0xFFFFC479),
            400: Color(0xFFFFB85D),
            500: Color(primaryColor),
            600: Color(0xFFFFA43A),
            700: Color(0xFFFF9A32),
            800: Color(0xFFFF912A),
            900: Color(0xFFFF801C),
          },
        ),
      ),
      home: const LandingView(),
    );
  }
}
