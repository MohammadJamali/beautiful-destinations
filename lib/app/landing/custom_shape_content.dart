import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomShapeContentWidget extends StatelessWidget {
  const CustomShapeContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Padding(
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
              localizations.slogan,
              style: theme.textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
