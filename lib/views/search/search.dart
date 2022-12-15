import 'package:beautiful_destinations/extensions/enum_extension.dart';
import 'package:beautiful_destinations/models/enums/screen_type.dart';
import 'package:beautiful_destinations/views/constant.dart';
import 'package:beautiful_destinations/views/search/filter.dart';
import 'package:beautiful_destinations/widgets/bottom_nav_bar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchView extends StatefulWidget {
  static const route = '/search/filter';
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late AppLocalizations _localizations;
  late MediaQueryData _mediaQuery;
  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context)!;
    _mediaQuery = MediaQuery.of(context);
    _theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount;
    switch (_mediaQuery.getScreenType()) {
      case ScreenType.extraLarge:
      case ScreenType.large:
      case ScreenType.medium:
        crossAxisCount = 3;
        break;
      default:
        crossAxisCount = 2;
    }

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
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(32),
                                bottomStart: Radius.circular(32),
                              ).resolve(Directionality.of(context)),
                              child: const SizedBox(
                                height: 50,
                                width: 60,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                              width: 0,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: _localizations.searchHint,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    alignLabelWithHint: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8.0),
                      child: Material(
                        color: _theme.primaryColor,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(FilterView.routeName);
                          },
                          splashColor: Colors.orange,
                          customBorder: const CircleBorder(),
                          child: Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/images/sliders.svg',
                              height: 24,
                              color: Colors.white,
                              semanticsLabel: 'Beautiful Destinations',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  left: 24,
                  right: 24,
                ),
                child: Text(
                  _localizations.recent,
                  style: _theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Wrap(
                  spacing: 8,
                  children: snapList
                      .map(
                        (e) => Chip(
                          elevation: 0,
                          label: Text(e['title'] as String),
                          backgroundColor: Colors.grey.shade100,
                          deleteIconColor: Colors.grey.shade400,
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () {},
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  bottom: 16,
                  left: 24,
                  right: 24,
                ),
                child: Text(
                  _localizations.suggestions,
                  style: _theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24.0,
                  mainAxisSpacing: 24.0,
                  childAspectRatio: 0.75,
                  children: snapList
                      .map(
                        (e) => ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  e['thumbnail']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Colors.black26,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    e['title']!,
                                    textAlign: TextAlign.center,
                                    style:
                                        _theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
