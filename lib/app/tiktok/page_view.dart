import 'dart:math';

import 'package:beautiful_destinations/extensions/number_extention.dart';
import 'package:beautiful_destinations/repositories/models/tiktok.dart';
import 'package:beautiful_destinations/app/book/detail.dart';
import 'package:beautiful_destinations/widgets/circle_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:video_player/video_player.dart';

class TiktokPageView extends StatefulWidget {
  final TiktokModel model;

  const TiktokPageView(this.model, {super.key});

  @override
  State<TiktokPageView> createState() => _TiktokPageViewState();
}

class _TiktokPageViewState extends State<TiktokPageView> {
  // out-sourced funtionalities, geting injected by `InheritedWidget`
  late AppLocalizations _localizations;
  late MediaQueryData _mediaQuery;
  late ThemeData _theme;

  late VideoPlayerController _videoController;
  late Future _initializeVideoPlayerFuture;
  late Size _buttonSize;

  late TextStyle _iconButtonTextStyle;

  late final NumberFormat rateFormat;

  late bool isLiked;

  _TiktokPageViewState() {
    rateFormat = NumberFormat("#,##0.00");
  }

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.model.video);
    _initializeVideoPlayerFuture = _videoController.initialize();
    _videoController.setLooping(true);
    _videoController.play();

    isLiked = widget.model.isLiked;
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context)!;
    _mediaQuery = MediaQuery.of(context);
    _theme = Theme.of(context);

    _buttonSize = Size(min(300, _mediaQuery.size.width * 0.8), 50);
    _iconButtonTextStyle = _theme.textTheme.bodyText1!.copyWith(
      color: Colors.white70,
    );

    super.didChangeDependencies();
  }

  void onLikePressed() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  void onSharePressed() {}

  void onCommentPressed() {}

  Future<void> onDetailsPressed(String id) async {
    final navigator = Navigator.of(context);

    await _videoController.pause();
    await navigator.pushNamed(
      DetailView.routeName,
      arguments: {
        'id': id,
        'imageHeroTag': UniqueKey(),
      },
    );
    await _videoController.play();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_videoController.value.isInitialized) return;
        if (_videoController.value.isPlaying) {
          _videoController.pause();
        } else {
          _videoController.play();
        }
      },
      child: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return Positioned.fill(
                //   child: Image.asset(
                //     widget.model.imageUrl,
                //     fit: BoxFit.cover,
                //   ),
                // );
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
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xD60F0F0F),
                  Color(0x00000000),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 0.5],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: VideoProgressIndicator(
              _videoController,
              colors: const VideoProgressColors(
                playedColor: Colors.white,
                backgroundColor: Colors.white24,
                bufferedColor: Colors.white38,
              ),
              allowScrubbing: false,
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 8,
                                ),
                                child: Text(
                                  widget.model.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: _theme.textTheme.headline4?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (widget.model.description != null)
                                Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 100,
                                    minHeight: 50,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        widget.model.description!,
                                        textAlign: TextAlign.justify,
                                        style: _theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: const Color(0xE6FFFFFF),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //     horizontal: 24,
                              //     vertical: 8,
                              //   ),
                              //   child: Row(
                              //     children: [
                              //       RatingStar(maxRate: 5, rate: widget.model.rate),
                              //       Expanded(
                              //         child: Padding(
                              //           padding: const EdgeInsets.symmetric(
                              //               horizontal: 8),
                              //           child: Text(
                              //             '${rateFormat.format(widget.model.rate)} (${widget.model.reviews} reviwes)',
                              //             maxLines: 1,
                              //             softWrap: false,
                              //             style:
                              //                 _theme.textTheme.bodyText1?.copyWith(
                              //               color: const Color(0xE6FFFFFF),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Wrap(
                          spacing: 16,
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            CircleIconButton(
                              icon: const Icon(
                                Icons.comment_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                              text:
                                  widget.model.comments.humanReadableNumber() ??
                                      '-',
                              textStyle: _iconButtonTextStyle,
                              onTap: onCommentPressed,
                            ),
                            CircleIconButton(
                              icon: const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 32,
                              ),
                              text: _localizations.share,
                              textStyle: _iconButtonTextStyle,
                              onTap: onSharePressed,
                            ),
                            LikeButton(
                              isLiked: isLiked,
                              likeCount: widget.model.likes,
                              countPostion: CountPostion.bottom,
                            ),
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 32,
                          left: 8,
                          right: 8,
                        ),
                        child: ElevatedButton(
                          onPressed: () => onDetailsPressed(widget.model.id),
                          style: ElevatedButton.styleFrom(
                            minimumSize: _buttonSize,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          child: Text(_localizations.details),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
}
