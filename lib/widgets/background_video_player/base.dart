import 'package:flutter/material.dart';

enum BackgroundVideoType {
  file,
  network,
  asset,
}

abstract class BaseBackgroundVideoPlayer extends StatefulWidget {
  final Widget child;
  final BackgroundVideoType type;
  final String resource;
  const BaseBackgroundVideoPlayer({
    super.key,
    required this.type,
    required this.resource,
    required this.child,
  });
}
