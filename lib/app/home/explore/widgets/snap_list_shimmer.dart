import 'dart:math';

import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:beautiful_destinations/repositories/models/video_category.dart';

typedef AsyncSnapListCallback = Future<void> Function(PlaceCategoryModel);

class SnapListShimmer extends StatelessWidget {
  const SnapListShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(32)),
    this.baseColor = const Color(0xFFBDBDBD), // grey.shade400
    this.highlightColor = const Color(0xFFE0E0E0), // grey.shade300
    this.backgroundColor = const Color(0xFFEEEEEE), // grey.shade200
  });

  final double width;
  final double height;
  final Color baseColor;
  final Color highlightColor;
  final Color backgroundColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
      dynamicItemSize: true,
      focusOnItemTap: false,
      shrinkWrap: true,
      initialIndex: 1,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemSize: width,
      onItemFocus: (index) {},
      itemBuilder: (context, index) {
        return Container(
          width: width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(width: 1, color: highlightColor),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: Container(
                    width: width,
                    height: max(200, height * 0.4),
                    padding: const EdgeInsets.all(8),
                    color: backgroundColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              height: 16,
                              width: width / 1.5 - 48,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Wrap(
                              spacing: 8,
                              direction: Axis.vertical,
                              children: [
                                for (var i = 0; i < 2; i++)
                                  Shimmer.fromColors(
                                    baseColor: baseColor,
                                    highlightColor: highlightColor,
                                    child: Container(
                                      height: 8,
                                      width: width / 1.2 - 48,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            width: min(140, width - 48),
                            height: 40,
                            margin: const EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              border: Border.all(width: 2, color: baseColor),
                            ),
                          ),
                        ),
                      ],
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
