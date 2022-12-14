import 'dart:math';
import 'dart:ui';

import 'package:beautiful_destinations/views/authentication/login.dart';
import 'package:beautiful_destinations/views/landing/custom_shape/clipper.dart';
import 'package:beautiful_destinations/widgets/background_video_player/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beautiful_destinations/widgets/background_video_player/video_player.dart';

class LandingView extends StatefulWidget {
  static const routeName = '/landing';
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  late AppLocalizations _localizations;
  late MediaQueryData _mediaQuery;
  late ThemeData _theme;

  bool useBlurScreen = true;
  double _customCardWidth = 350;
  double _customCardHeight = 350 * 0.75;
  EdgeInsets _customCardContainerPadding = const EdgeInsets.only(bottom: 128);
  EdgeInsets _customCardButtomPadding =
      const EdgeInsets.only(bottom: 350 * 0.12);
  Size _buttonSize = const Size.square(350 * 0.2);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  void _computeCustomCardSize() {
    _customCardWidth = _mediaQuery.size.width - (24 * 2);
    _customCardWidth = min(_customCardWidth, 350);
    _customCardHeight = _customCardWidth * 0.75;
    _customCardButtomPadding = EdgeInsets.only(bottom: _customCardWidth * 0.12);
    _customCardContainerPadding = EdgeInsets.only(
      top: max(
          0,
          (_mediaQuery.size.height -
                  _customCardHeight -
                  _customCardButtomPadding.bottom) /
              1.3),
    );
    _buttonSize = Size.square(_customCardWidth * 0.2);
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context)!;
    _mediaQuery = MediaQuery.of(context);
    _theme = Theme.of(context);

    _computeCustomCardSize();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundVideoPlayer(
      resource: 'assets/mock/landing.mp4',
      type: BackgroundVideoType.asset,
      child: SingleChildScrollView(
        child: Padding(
          padding: _customCardContainerPadding,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: _customCardButtomPadding,
                  child: ClipPath(
                    clipper: LandingShapeClipper(),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: useBlurScreen ? 5.0 : 0.0,
                        sigmaY: useBlurScreen ? 5.0 : 0.0,
                      ),
                      child: Container(
                        color: Colors.white38,
                        width: _customCardWidth,
                        height: _customCardHeight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 32,
                            left: 16,
                            right: 16,
                            bottom: 64,
                          ),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/images/logo_inline_black.svg',
                                height: 75,
                                semanticsLabel: 'Beautiful Destinations',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Text(
                                  _localizations.slogan,
                                  style: _theme.textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(
                        LoginView.routeName,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      fixedSize: _buttonSize,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(
                        'assets/images/plane_departure_solid.svg',
                        color: _theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }
}
