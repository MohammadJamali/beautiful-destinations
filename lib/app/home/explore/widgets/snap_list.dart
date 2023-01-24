import 'dart:math';
import 'dart:ui';

import 'package:beautiful_destinations/repositories/models/video_category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef AsyncSnapListCallback = Future<void> Function(PlaceCategoryModel);

class SnapList extends StatelessWidget {
  const SnapList({
    super.key,
    required this.models,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  final double width;
  final double height;
  final AsyncSnapListCallback onPressed;
  final List<PlaceCategoryModel> models;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return ScrollSnapList(
      dynamicItemSize: true,
      initialIndex: 1,
      itemCount: models.length,
      itemSize: width,
      onItemFocus: (index) {},
      itemBuilder: (context, index) {
        final model = models[index];

        return Container(
          width: width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(32),
            ),
            image: DecorationImage(
              image: NetworkImage(
                model.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 3.0,
                      sigmaY: 3.0,
                    ),
                    child: Container(
                      width: width,
                      height: max(200, height * 0.4),
                      padding: const EdgeInsets.all(8),
                      color: Colors.black26,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              model.title,
                              style: theme.textTheme.headline5?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  model.description,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => onPressed(model),
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                              ),
                              elevation: 0,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: Text(localizations.explore),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
