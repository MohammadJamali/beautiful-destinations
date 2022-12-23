import 'dart:io';

import 'package:beautiful_destinations/app/authentication/view/auth_code.dart';
import 'package:beautiful_destinations/app/authentication/view/login.dart';
import 'package:beautiful_destinations/app/book/detail.dart';
import 'package:beautiful_destinations/app/home/search/filter.dart';
import 'package:beautiful_destinations/app/navigation/settings/bloc/settings_bloc.dart';
import 'package:beautiful_destinations/app/tiktok/tiktok_video_view.dart';
import 'package:beautiful_destinations/app/landing/landing.dart';
import 'package:beautiful_destinations/app/home/home.dart';
import 'package:beautiful_destinations/app/navigation/menu.dart';
import 'package:beautiful_destinations/app/notification/notification.dart';
import 'package:beautiful_destinations/repositories/authentication/models/enums/status.dart';
import 'package:beautiful_destinations/repositories/authentication/repository.dart';
import 'package:beautiful_destinations/repositories/models/enums/brightness.dart';
import 'package:beautiful_destinations/repositories/place/place_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

late SharedPreferences sharesPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharesPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (Platform.isLinux || Platform.isWindows) {
    DartVLC.initialize();
  }
  runApp(const TourismApp());
}

class TourismApp extends StatelessWidget {
  const TourismApp({super.key});

  ThemeData get darkBrightness => ThemeData(
        fontFamily: "manrope",
        primarySwatch: const MaterialColor(
          0xFFffab40, // primaryColor
          <int, Color>{
            50: Color(0xFFFFF5E8),
            100: Color(0xFFFFE6C6),
            200: Color(0xFFFFD5A0),
            300: Color(0xFFFFC479),
            400: Color(0xFFFFB85D),
            500: Color(0xFFffab40), // primaryColor
            600: Color(0xFFFFA43A),
            700: Color(0xFFFF9A32),
            800: Color(0xFFFF912A),
            900: Color(0xFFFF801C),
          },
        ),
      );

  ThemeData get lightBrightness => ThemeData(
        fontFamily: "manrope",
        primarySwatch: const MaterialColor(
          0xFFffab40, // primaryColor
          <int, Color>{
            50: Color(0xFFFFF5E8),
            100: Color(0xFFFFE6C6),
            200: Color(0xFFFFD5A0),
            300: Color(0xFFFFC479),
            400: Color(0xFFFFB85D),
            500: Color(0xFFffab40), // primaryColor
            600: Color(0xFFFFA43A),
            700: Color(0xFFFF9A32),
            800: Color(0xFFFF912A),
            900: Color(0xFFFF801C),
          },
        ),
      );

  ThemeData getBrightness(MoreBrightness moreBrightness) {
    final brightness = moreBrightness == MoreBrightness.systemDefault
        ? MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .platformBrightness
        : Brightness.values.byName(moreBrightness.name);

    if (brightness == Brightness.dark) return darkBrightness;
    return lightBrightness;
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthenticationRepository()),
        RepositoryProvider(
          create: (_) => PlaceRepository(FirebaseFirestore.instance),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (BuildContext providerContext) => SettingsBloc(
              sharedPreferences: sharesPreferences,
              authenticationRepository:
                  providerContext.read<AuthenticationRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (BuildContext context, state) => MaterialApp(
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: true,
            locale: state.locale,
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
            theme: getBrightness(state.brightness),
            home: state.authStatus == AuthenticationStatus.unauthenticated
                ? const LandingView()
                : const MainView(),
          ),
        ),
      ),
    );
  }
}
