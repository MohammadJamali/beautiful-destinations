import 'dart:math';
import 'package:beautiful_destinations/app/authentication/view/login.dart';
import 'package:beautiful_destinations/app/landing/widgets/custom_shape.dart';
import 'package:beautiful_destinations/widgets/background_video_player/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beautiful_destinations/widgets/background_video_player/video_player.dart';

import 'custom_shape_content.dart';

class LandingView extends StatefulWidget {
  static const routeName = '/landing';
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  late ThemeData _theme;
  late MediaQueryData _mediaQuery;

  Size shapeSize = const Size(350, 350 * 0.75);
  Size buttonSize = const Size.square(350 * 0.2);
  EdgeInsets shapePadding = const EdgeInsets.only(bottom: 350 * 0.12);
  EdgeInsets shapeContainerPadding = const EdgeInsets.only(bottom: 128);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void didChangeDependencies() {
    _mediaQuery = MediaQuery.of(context);
    _theme = Theme.of(context);

    _computeCustomShapeSize();

    super.didChangeDependencies();
  }

  void _computeCustomShapeSize() {
    // 24 unit padding each side, 350 unit as the max width
    final shapeWidth = min(_mediaQuery.size.width - 48, 350).toDouble();
    shapeSize = Size(shapeWidth, shapeWidth * 0.75);

    buttonSize = Size.square(shapeWidth * 0.2);

    shapePadding = EdgeInsets.only(bottom: shapeWidth * 0.12);

    shapeContainerPadding = EdgeInsets.only(
      top: max(
          0,
          (_mediaQuery.size.height - shapeSize.height - shapePadding.bottom) /
              1.3),
    );
  }

  Widget planeDepartureButton() => ElevatedButton(
        onPressed: onPlaneDepartureButtonPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          elevation: 0,
          fixedSize: buttonSize,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(
            'assets/images/plane_departure_solid.svg',
            color: _theme.primaryColor,
          ),
        ),
      );

  void onPlaneDepartureButtonPressed() {
    Navigator.of(context).popAndPushNamed(
      LoginView.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundVideoPlayer(
      resource: 'assets/mock/landing.mp4',
      type: BackgroundVideoType.asset,
      child: SingleChildScrollView(
        child: Padding(
          padding: shapeContainerPadding,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: shapePadding,
                  child: CustomShape(
                    width: shapeSize.width,
                    height: shapeSize.height,
                    child: const CustomShapeContentWidget(),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: planeDepartureButton(),
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
