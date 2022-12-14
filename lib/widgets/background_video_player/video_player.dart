import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_macos/video_player_macos.dart';

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

  late VideoPlayerController _videoController;
  late Future _initializeVideoPlayerFuture;

  @override
  void didChangeDependencies() {
    _mediaQuery = MediaQuery.of(context);

    initiateVideoPlayer();

    super.didChangeDependencies();
  }

  void initiateVideoPlayer() {
    switch (widget.type) {
      case BackgroundVideoType.asset:
        _videoController = VideoPlayerController.asset(widget.resource);
        break;
      case BackgroundVideoType.network:
        _videoController = VideoPlayerController.network(widget.resource);
        break;
      case BackgroundVideoType.file:
        _videoController = VideoPlayerController.file(File(widget.resource));
        break;
      default:
        throw Exception("Invalid media type for target platform");
    }
    _initializeVideoPlayerFuture = _videoController.initialize();
    _videoController.setLooping(true);
    _videoController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox.fromSize(
                    size: _videoController.value.size,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              );
            }
          },
        ),
        widget.child,
      ],
    );
  }

  @override
  void dispose() {
    _videoController.pause();
    _videoController.dispose();

    super.dispose();
  }
}
