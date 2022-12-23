import 'package:badges/badges.dart';
import 'package:beautiful_destinations/app/home/explore/explore.dart';
import 'package:beautiful_destinations/app/navigation/menu.dart';
import 'package:beautiful_destinations/app/notification/notification.dart';
import 'package:beautiful_destinations/app/home/widgets/bottom_nav_bar/item.dart';
import 'package:beautiful_destinations/app/home/widgets/bottom_nav_bar/navbar.dart';
import 'package:beautiful_destinations/widgets/circle_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bookmarked/bookmarked.dart';
import 'search/search.dart';

class MainView extends StatefulWidget {
  static const routeName = '/home';

  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  late AppLocalizations _localizations;
  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context)!;
    _theme = Theme.of(context);

    super.didChangeDependencies();
  }

  void onNotificationPressed() {
    Navigator.of(context).pushNamed(NotificationView.routeName);
  }

  void onButtomNavigatorExplorePressed() {
    Navigator.of(context).pushNamed(ExploreView.routeName);
  }

  void onProfilePicturePressed() {
    Navigator.of(context).pushNamed(NavigationMenu.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/logo_black.svg',
          height: 36,
          semanticsLabel: 'Beautiful Destinations',
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              child: Ink.image(
                image: const AssetImage('assets/mock/profile.jpg'),
                width: 42,
                height: 42,
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: onProfilePicturePressed,
                ),
              ),
            ),
          ),
        ],
        leading: CircleIconButton(
          icon: Badge(
            badgeContent: Text(
              '2',
              style: _theme.textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
            ),
            elevation: 0,
            position: BadgePosition.topEnd(end: -4, top: -4),
            child: const Icon(
              Icons.notifications_rounded,
              size: 30.0,
            ),
          ),
          onTap: onNotificationPressed,
          padding: const EdgeInsetsDirectional.only(start: 4),
        ),
        elevation: 0,
        backgroundColor: _theme.canvasColor,
      ),
      body: DefaultTabController(
        length: 3,
        child: FloatingBottomNavbar(
          color: _theme.primaryColor,
          unselectedColor: Colors.white,
          start: 30,
          end: 2,
          actions: [
            FloatingBottomNavbarAction(
              onTap: onButtomNavigatorExplorePressed,
              child: const Icon(Icons.explore),
            ),
          ],
          tabs: [
            FloatingBottomNavbarItem(
              icon: Icons.home_rounded,
              text: _localizations.home,
            ),
            FloatingBottomNavbarItem(
              icon: Icons.bookmark,
              text: _localizations.bookmarked,
            ),
            FloatingBottomNavbarItem(
              icon: Icons.search,
              text: _localizations.search,
            ),
          ],
          child: const TabBarView(
            dragStartBehavior: DragStartBehavior.down,
            physics: BouncingScrollPhysics(),
            children: [
              ExploreView(),
              BookmarkView(),
              SearchView(),
            ],
          ),
        ),
      ),
    );
  }
}
