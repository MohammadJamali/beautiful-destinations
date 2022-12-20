import 'package:auto_size_text/auto_size_text.dart';
import 'package:beautiful_destinations/extensions/enum_extension.dart';
import 'package:beautiful_destinations/app/book/detail.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:beautiful_destinations/repositories/models/ongoing_trip.dart';

class OnGoingTripWidget extends StatefulWidget {
  final OngoingTripModel model;
  const OnGoingTripWidget({
    super.key,
    required this.model,
  });

  @override
  State<OnGoingTripWidget> createState() => _OnGoingTripWidgetState();
}

class _OnGoingTripWidgetState extends State<OnGoingTripWidget> {
  late AppLocalizations _localizations;
  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context)!;
    _theme = Theme.of(context);

    super.didChangeDependencies();
  }

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: ValueKey('ongoing_${widget.model.id}'),
              child: Container(
                height: 200,
                width: double.infinity,
                // margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  image: DecorationImage(
                    image: AssetImage(widget.model.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.pin_drop,
                                color: Colors.white,
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: 8.0,
                                  ),
                                  child: Text(
                                    widget.model.location,
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.clip,
                                    style: _theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: OutlinedButton(
                        onPressed: () => onPlaceCardPressed(
                          widget.model.id,
                          ValueKey('ongoing_${widget.model.id}'),
                        ),
                        style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: _theme.primaryColor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        child: Text(
                          _localizations.details,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                left: 16,
                right: 16,
              ),
              child: Text(
                _localizations.schedule,
                style: _theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16,
                bottom: 16,
              ),
              child: FixedTimeline.tileBuilder(
                theme: TimelineThemeData(
                  nodePosition: 0,
                  color: Colors.grey.shade300,
                  indicatorTheme: const IndicatorThemeData(
                    position: 0,
                  ),
                  connectorTheme: const ConnectorThemeData(
                    indent: 8,
                    thickness: 2.5,
                  ),
                ),
                builder: TimelineTileBuilder.connected(
                  connectionDirection: ConnectionDirection.before,
                  itemCount: widget.model.timeline.length,
                  contentsBuilder: (_, index) {
                    final timeline = widget.model.timeline[index];
                    return Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 16,
                        bottom: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            timeline.title,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.clip,
                            style: _theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              timeline.time != null
                                  ? '${timeline.time} - ${timeline.description}'
                                  : timeline.description,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: _theme.textTheme.caption?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  indicatorBuilder: (_, index) {
                    final timeline = widget.model.timeline[index];
                    if (timeline.done) {
                      return Indicator.widget(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 70,
                              height: 20,
                              child: AutoSizeText(
                                timeline.date,
                                style: _theme.textTheme.bodyText1?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _theme.primaryColor,
                              ),
                              width: 32,
                              height: 32,
                              child: Icon(
                                timeline.iconClass.iconData(timeline.icon),
                                color: Colors.white,
                                size: 16.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Indicator.widget(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 70,
                              height: 20,
                            ),
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              width: 32,
                              height: 32,
                              child: Icon(
                                timeline.iconClass.iconData(timeline.icon),
                                color: Colors.grey,
                                size: 16.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  connectorBuilder: (_, index, ___) => Padding(
                    padding: const EdgeInsetsDirectional.only(start: 76),
                    child: SolidLineConnector(
                      color: widget.model.timeline[index].done
                          ? _theme.primaryColor
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onPlaceCardPressed(String id, Object imageHeroTag) async {
    Navigator.of(context).pushNamed(
      DetailView.routeName,
      arguments: {
        'id': id,
        'imageHeroTag': imageHeroTag,
      },
    );
  }
}
