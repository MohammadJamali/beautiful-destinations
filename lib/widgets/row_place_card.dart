import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:beautiful_destinations/extensions/enum_extension.dart';
import 'package:beautiful_destinations/repositories/models/place_option.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'circle_button.dart';

class RowPlaceCard extends StatelessWidget {
  final AsyncCallback onTab;
  final AsyncCallback onActionTab;
  final AsyncCallback? onBookingTab;
  final Widget action;
  final String? assetImage;
  final String? networkImage;
  final String title;
  final String? description;
  final List<PlaceOptionModel>? options;

  final double price;

  final Object imageHeroTag;

  const RowPlaceCard({
    super.key,
    required this.onTab,
    required this.title,
    required this.price,
    required this.action,
    required this.onActionTab,
    required this.imageHeroTag,
    this.options,
    this.description,
    this.assetImage,
    this.networkImage,
    this.onBookingTab,
  });

  List<Widget> _getOptionWidgets(ThemeData theme) {
    final List<Widget> optionWidgets = [];
    if (options?.isNotEmpty == true) {
      for (final option in options!) {
        optionWidgets.addAll([
          Icon(
            option.iconClass.iconData(option.icon),
            size: 18,
            color: theme.disabledColor,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 4,
              end: 8,
            ),
            child: Text(
              option.value,
              style: theme.textTheme.caption?.copyWith(
                color: theme.disabledColor,
              ),
            ),
          ),
        ]);
      }
    }
    return optionWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final optionWidgets = _getOptionWidgets(theme);

    final header = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: imageHeroTag,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: assetImage != null
                ? Image.asset(
                    assetImage!,
                    width: 105,
                    height: 105,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    networkImage!,
                    width: 105,
                    height: 105,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 16,
            ),
            child: SizedBox(
              height: 105,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        description!,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: theme.textTheme.caption,
                      ),
                    ),
                  if (optionWidgets.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(children: optionWidgets),
                    ),
                  if (onBookingTab == null) ...[
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        '$price\$',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
        CircleIconButton(
          icon: action,
          onTap: onActionTab,
          backgroundColor: Colors.white54,
          size: 24,
        ),
      ],
    );

    if (onBookingTab == null) {
      return GestureDetector(
        onTap: onTab,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(padding: const EdgeInsets.all(8.0), child: header),
        ),
      );
    }

    final localizations = AppLocalizations.of(context)!;

    final buttonSize = Size(min(150, mediaQuery.size.width * 0.4), 40);
    final footer = Column(
      children: [
        header,
        const Divider(height: 32),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.total,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('$price\$')
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: buttonSize,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Text(
                  localizations.rebooking,
                ),
              )
            ],
          ),
        )
      ],
    );

    return GestureDetector(
      onTap: onTab,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(padding: const EdgeInsets.all(8.0), child: footer),
      ),
    );
  }
}
