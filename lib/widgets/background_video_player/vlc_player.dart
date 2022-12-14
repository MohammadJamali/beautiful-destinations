import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

import 'base.dart';

class BackgroundVideoPlayer extends BaseBackgroundVideoPlayer {
  const BackgroundVideoPlayer({
    super.key,
    required BackgroundVideoType type,
    required String resource,
    required Widget child,
  }) : super(
          child: child,
          resource: resource,
          type: type,
        );

  @override
  State<BackgroundVideoPlayer> createState() => _BackgroundVideoPlayerState();
}

class _BackgroundVideoPlayerState extends State<BackgroundVideoPlayer> {
  late MediaQueryData _mediaQuery;
  late Player _vlcPlayer;

  @override
  void didChangeDependencies() {
    _mediaQuery = MediaQuery.of(context);

    initiateVideoPlayer();

    super.didChangeDependencies();
  }

  void initiateVideoPlayer() {
    final Media media;
    switch (widget.type) {
      case BackgroundVideoType.asset:
        media = Media.asset(widget.resource);
        break;

      case BackgroundVideoType.network:
        media = Media.network(widget.resource);
        break;

      case BackgroundVideoType.file:
        media = Media.file(File(widget.resource));
        break;

      default:
        throw Exception("Invalid media type for target platform");
    }

    _vlcPlayer = Player(id: 5252);
    _vlcPlayer.open(media, autoStart: true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Video(
          player: _vlcPlayer,
          height: _mediaQuery.size.height,
          width: _mediaQuery.size.width,
          scale: 1.0,
          showControls: false,
        ),
        widget.child,
      ],
    );
    // }
  }

  @override
  void dispose() {
    _vlcPlayer.stop();
    _vlcPlayer.dispose();
    super.dispose();
  }
}
