import 'dart:math';

import 'package:beautiful_destinations/views/constant.dart';
import 'package:beautiful_destinations/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class DetailView extends StatelessWidget {
  static const routeName = '/detail';
  const DetailView({super.key});

  Widget _chip(String lable, IconData icon, ThemeData theme) => Chip(
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
    final random = Random();
    final price = random.nextInt(400) + 100;
    final room = random.nextInt(3) + 1;
    final bed = random.nextInt(3) + 1;
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final localizations = AppLocalizations.of(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final model =
        snapList.where((element) => element['id'] == args['id']).first;
    final buttonSize = Size(min(150, mediaQuery.size.width * 0.4), 40);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: theme.canvasColor,
              elevation: 0,
              pinned: true,
              expandedHeight: mediaQuery.size.height * 0.5,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(80.0),
                child: SizedBox(),
              ),
              leading: Container(),
              actions: const [],
              title: Container(),
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Hero(
                        tag: args['imageHeroTag'],
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            model['thumbnail']!,
                            height: mediaQuery.size.height * 0.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: CircleIconButton(
                      icon: const Icon(
                        Icons.bookmark_outline_outlined,
                        size: 24,
                      ),
                      size: 50,
                      backgroundColor: Colors.white60,
                      padding: const EdgeInsetsDirectional.only(
                        top: 42,
                        end: 42,
                      ),
                      onTap: () {},
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CircleIconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 24,
                      ),
                      size: 50,
                      backgroundColor: Colors.white60,
                      padding: const EdgeInsetsDirectional.only(
                        top: 42,
                        start: 42,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16),
                      child: Text(
                        model['title']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.headline5?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text('325'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset(
                        'assets/images/heart_solid.svg',
                        semanticsLabel: 'Acme Logo',
                        width: 24,
                        height: 24,
                        color: Colors.red.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: theme.primaryColor),
                    Text(
                      '123 sth, sqr, City, Country',
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    _chip('$bed', Icons.king_bed_rounded, theme),
                    _chip('$room', Icons.water_drop_rounded, theme),
                    _chip('$room', Icons.food_bank_rounded, theme),
                    _chip('$room', Icons.meeting_room, theme),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  model['description']!,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 24),
              sliver: SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Wrap(
                      spacing: 16,
                      children: snapList
                              .take(3)
                              .map(
                                (e) => ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Material(
                                    clipBehavior: Clip.antiAlias,
                                    color: Colors.transparent,
                                    child: Ink.image(
                                      image: AssetImage(e['thumbnail']!),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      child: InkWell(
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList() +
                          [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Material(
                                clipBehavior: Clip.antiAlias,
                                color: Colors.transparent,
                                child: Ink.image(
                                  image: AssetImage(snapList[3]['thumbnail']!),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      color: Colors.black45,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "+5",
                                        style:
                                            theme.textTheme.headline4?.copyWith(
                                          color: const Color(0xDCFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: 64,
              ),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizations!.price,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$price\$',
                          style: theme.textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: buttonSize,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      child: Text(
                        localizations.bookNow,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
