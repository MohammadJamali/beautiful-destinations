import 'package:beautiful_destinations/extensions/enum_extension.dart';
import 'package:beautiful_destinations/models/place_option.dart';
import 'package:beautiful_destinations/widgets/circle_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MediumPlaceCard extends StatelessWidget {
  final AsyncCallback onTab;
  final AsyncCallback onActionTab;
  final Widget action;
  final String? assetImage;
  final String? networkImage;
  final String title;
  final String? description;
  final List<PlaceOptionModel>? options;

  final Object imageHeroTag;

  final double price;
  final double width;

  const MediumPlaceCard({
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
    this.width = 220,
  });

  Widget _chip(ThemeData theme, String lable, IconData icon) => Chip(
        elevation: 0,
        padding: const EdgeInsets.all(4),
        backgroundColor: Colors.grey.shade100,
        labelPadding: const EdgeInsetsDirectional.only(end: 4),
        avatar: Icon(
          icon,
          size: 18,
          color: theme.disabledColor,
        ),
        label: Text(
          lable,
          style: theme.textTheme.caption?.copyWith(
            color: theme.disabledColor,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTab,
      child: SizedBox(
        width: width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    children: [
                      Hero(
                        tag: imageHeroTag,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          child: networkImage != null
                              ? Image.network(
                                  networkImage!,
                                  width: 200,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                              : assetImage != null
                                  ? Image.asset(
                                      assetImage!,
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: CircleIconButton(
                              icon: action,
                              onTap: onActionTab,
                              backgroundColor: Colors.white54,
                              size: 50,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$price\$',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (description != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Text(
                      description!,
                      style: theme.textTheme.caption,
                    ),
                  ),
                if (options != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: options!
                          .map(
                            (e) => _chip(
                              theme,
                              e.value,
                              e.iconClass.iconData(e.icon),
                            ),
                          )
                          .toList(),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
