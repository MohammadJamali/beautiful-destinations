import 'dart:math';
import 'dart:ui';

import 'package:beautiful_destinations/models/enums/icon_class.dart';
import 'package:beautiful_destinations/models/place_option.dart';
import 'package:beautiful_destinations/views/book/detail.dart';
import 'package:beautiful_destinations/views/constant.dart';
import 'package:beautiful_destinations/views/tiktok/explore_view.dart';
import 'package:beautiful_destinations/widgets/bottom_nav_bar/navbar.dart';
import 'package:beautiful_destinations/widgets/medium_place_card.dart';
import 'package:beautiful_destinations/widgets/row_place_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late AppLocalizations _localizations;
  late MediaQueryData _mediaQuery;
  late ThemeData _theme;

  late double _snapListHight;
  late double _snapListWidth;

  final random = Random();

  void _computeCustomCardSize() {
    _snapListHight = max(400, _mediaQuery.size.height * 0.62);
    // _snapListWidth = _mediaQuery.size.width * 0.76;
    _snapListWidth = _snapListHight * (9 / 16);
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context)!;
    _mediaQuery = MediaQuery.of(context);
    _theme = Theme.of(context);

    _computeCustomCardSize();

    super.didChangeDependencies();
  }

  void onButtomNavigatorExplorePressed(String id) {
    Navigator.of(context).pushNamed(ExploreView.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: InheritedDataProvider.of(context).scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _snapListHight,
              child: ScrollSnapList(
                dynamicItemSize: true,
                initialIndex: 1,
                itemCount: snapList.length,
                itemSize: _snapListWidth,
                onItemFocus: (index) {},
                itemBuilder: (context, index) {
                  return Container(
                    width: _snapListWidth,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          snapList[index]['thumbnail']!,
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
                                width: _snapListWidth,
                                height: max(200, _snapListHight * 0.4),
                                padding: const EdgeInsets.all(8),
                                color: Colors.black26,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Text(
                                        snapList[index]['title']!,
                                        style: _theme.textTheme.headline5
                                            ?.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: SingleChildScrollView(
                                          child: Text(
                                            snapList[index]['description']!
                                                .substring(0, 100),
                                            style: _theme.textTheme.bodyMedium
                                                ?.copyWith(
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          onButtomNavigatorExplorePressed(
                                              snapList[index]['id']!),
                                      style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              32,
                                            ),
                                          ),
                                        ),
                                        // backgroundColor: Colors.white,
                                        elevation: 0,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0,
                                        ),
                                        child: Text(_localizations.explore),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
                bottom: 16,
                left: 24,
                right: 24,
              ),
              child: Text(
                _localizations.popular,
                style: _theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Wrap(
                  spacing: 16,
                  children: snapList
                      .asMap()
                      .map(
                        (index, e) => MapEntry(
                          index,
                          MediumPlaceCard(
                            imageHeroTag: ValueKey('col_${e['id']}'),
                            onTab: () => onPlaceCardPressed(
                              e['id']!,
                              ValueKey('col_${e['id']}'),
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
                            title: e['title']!,
                            description: e['description']!.substring(0, 100),
                            assetImage: e['thumbnail']!,
                            action: const Icon(
                              Icons.bookmark_border_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
                bottom: 16,
                left: 24,
                right: 24,
              ),
              child: Text(
                _localizations.featuredListed,
                style: _theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Wrap(
                spacing: 16,
                direction: Axis.horizontal,
                children: snapList
                    .map(
                      (e) => RowPlaceCard(
                        imageHeroTag: ValueKey('row_${e['id']}'),
                        title: e['title']!,
                        description: e['description']!,
                        assetImage: e['thumbnail']!,
                        onTab: () => onPlaceCardPressed(
                          e['id']!,
                          ValueKey('row_${e['id']}'),
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
                    )
                    .toList(),
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

  Future<void> onPlaceBookmarkPressed(String id) async {}
}
