import 'dart:math';

import 'package:beautiful_destinations/app/home/bookmarked/widgets/ongoing_trip.dart';
import 'package:beautiful_destinations/repositories/models/enums/icon_class.dart';
import 'package:beautiful_destinations/repositories/models/ongoing_trip.dart';
import 'package:beautiful_destinations/repositories/models/ongoing_trip_timeline.dart';
import 'package:beautiful_destinations/repositories/models/place_option.dart';
import 'package:beautiful_destinations/app/book/detail.dart';
import 'package:beautiful_destinations/app/constant.dart';
import 'package:beautiful_destinations/app/home/widgets/bottom_nav_bar/navbar.dart';
import 'package:beautiful_destinations/widgets/headline.dart';
import 'package:beautiful_destinations/widgets/row_place_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookmarkView extends StatefulWidget {
  static const String routeName = '/home/bookmark';

  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  late AppLocalizations _localizations;
  late ThemeData _theme;

  final random = Random();

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context)!;
    _theme = Theme.of(context);

    super.didChangeDependencies();
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

  Future<void> onPlaceBookmarkPressed(String id) async {}
  Future<void> onBookingTab(String id) async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: SingleChildScrollView(
        controller: InheritedDataProvider.of(context).scrollController,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  bottom: 16,
                  left: 24,
                  right: 24,
                ),
                child: Text(
                  _localizations.ongoing,
                  style: _theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              OnGoingTripWidget(
                model: OngoingTripModel(
                  id: snapList[0]['id']!,
                  title: snapList[0]['id']!,
                  location: snapList[0]['location']!,
                  imageUrl: snapList[0]['imageUrl']!,
                  timeline: [
                    OngoingTripTimelineModel(
                      id: 'kjfchnlhfnlaciunhn34n',
                      title: 'Airplan Reservation',
                      description: 'Airboss of America Corp.',
                      date: '2022-2-12',
                      time: '13:15',
                      done: true,
                      iconClass: IconClass.materialIcon,
                      icon: Icons.airplane_ticket.codePoint,
                    ),
                    OngoingTripTimelineModel(
                      id: '987jkdfshdfsnjdfs',
                      title: 'Hotel Reservation',
                      description: 'Airbnb Vacation rental company',
                      date: '2022-2-13',
                      time: '07:15',
                      done: true,
                      iconClass: IconClass.materialIcon,
                      icon: Icons.hotel_rounded.codePoint,
                    ),
                    OngoingTripTimelineModel(
                      id: '987jkdfshdfsnjdfs',
                      title: 'Tourism tour',
                      description: 'Miniature Tourism Group',
                      date: 'Pending',
                      done: false,
                      iconClass: IconClass.materialIcon,
                      icon: Icons.tour_rounded.codePoint,
                    ),
                    OngoingTripTimelineModel(
                      id: 'sdlfkmjdlsf9834jkhn',
                      title: 'Photographer',
                      description: 'Not determined yet',
                      date: 'Pending',
                      done: false,
                      iconClass: IconClass.materialIcon,
                      icon: Icons.camera_alt_rounded.codePoint,
                    ),
                  ],
                ),
              ),
              Headline(text: _localizations.history),
              ...snapList
                  .take(2)
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: RowPlaceCard(
                        imageHeroTag: ValueKey('row_${e['id']}'),
                        title: e['title']!,
                        description: e['description']!,
                        assetImage: e['imageUrl']!,
                        onTab: () => onPlaceCardPressed(
                          e['id']!,
                          ValueKey('row_${e['id']}'),
                        ),
                        onActionTab: () => onPlaceBookmarkPressed(e['id']!),
                        onBookingTab: () => onBookingTab(e['id']!),
                        price: random.nextInt(400) + 100,
                        options: [
                          PlaceOptionModel(
                            iconClass: IconClass.materialIcon,
                            icon: Icons.king_bed_rounded.codePoint,
                            value: '${random.nextInt(3) + 1}',
                          ),
                          PlaceOptionModel(
                            iconClass: IconClass.materialIcon,
                            icon: Icons.meeting_room.codePoint,
                            value: '${random.nextInt(3) + 1}',
                          ),
                        ],
                        action: const Icon(
                          Icons.bookmark_border_rounded,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              Headline(text: _localizations.bookmarked),
              Padding(
                padding: const EdgeInsets.only(
                  top: 32.0,
                  bottom: 16,
                  left: 24,
                  right: 24,
                ),
                child: Text(
                  _localizations.bookmarked,
                  style: _theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...snapList
                  .take(4)
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: RowPlaceCard(
                        imageHeroTag: ValueKey('row2_${e['id']}'),
                        title: e['title']!,
                        description: e['description']!,
                        assetImage: e['imageUrl']!,
                        onTab: () => onPlaceCardPressed(
                          e['id']!,
                          ValueKey('row2_${e['id']}'),
                        ),
                        onActionTab: () => onPlaceBookmarkPressed(e['id']!),
                        price: random.nextInt(400) + 100,
                        options: [
                          PlaceOptionModel(
                            iconClass: IconClass.materialIcon,
                            icon: Icons.king_bed_rounded.codePoint,
                            value: '${random.nextInt(3) + 1}',
                          ),
                          PlaceOptionModel(
                            iconClass: IconClass.materialIcon,
                            icon: Icons.meeting_room.codePoint,
                            value: '${random.nextInt(3) + 1}',
                          ),
                        ],
                        action: const Icon(
                          Icons.bookmark_border_rounded,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
