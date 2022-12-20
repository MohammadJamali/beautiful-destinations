import 'dart:math';
import 'dart:ui';

import 'package:beautiful_destinations/app/home/widgets/bottom_nav_bar/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FloatingBottomNavbar extends StatefulWidget {
  final List<FloatingBottomNavbarItem> tabs;
  final List<FloatingBottomNavbarAction>? actions;
  final Widget child;
  final Color color;
  final Color unselectedColor;
  final double end;
  final double start;
  const FloatingBottomNavbar({
    Key? key,
    required this.child,
    required this.color,
    required this.unselectedColor,
    required this.end,
    required this.start,
    required this.tabs,
    this.actions,
  }) : super(key: key);

  @override
  State<FloatingBottomNavbar> createState() => _FloatingBottomNavbarState();
}

class _FloatingBottomNavbarState extends State<FloatingBottomNavbar>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  TabController? _tabController;
  late ThemeData _theme;
  late double _navbarWidth;

  bool tabListenerAdded = false;
  bool isScrollingDown = false;
  bool isOnTop = true;

  @override
  void didChangeDependencies() {
    _theme = Theme.of(context);
    _navbarWidth = MediaQuery.of(context).size.width * 0.8;
    _navbarWidth = min(400, _navbarWidth);

    if (_tabController == null) {
      _tabController = DefaultTabController.of(context);
      _tabController?.addListener(onNewTab);
    }

    super.didChangeDependencies();
  }

  void onNewTab() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    scrollControllerAddListener();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, widget.end),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ))
      ..addListener(() {
        if (mounted) setState(() {});
      });
    _controller.forward();
  }

  Future<void> scrollControllerAddListener() async {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          isOnTop = false;
          hide();
        }
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          isOnTop = true;
          show();
        }
      }
    });
  }

  void show() {
    if (mounted) {
      setState(() {
        _controller.forward();
      });
    }
  }

  void hide() {
    if (mounted) {
      setState(() {
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TabBarTheme tabBarTheme = TabBarTheme.of(context);
    final actionButtonWidth = _navbarWidth /
        max(1, (widget.tabs.length + (widget.actions?.length ?? 0)));

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        InheritedDataProvider(
          scrollController: scrollController,
          child: widget.child,
        ),
        // Positioned(
        //   bottom: widget.start,
        //   child: AnimatedContainer(
        //     duration: const Duration(milliseconds: 300),
        //     curve: Curves.easeIn,
        //     width: isOnTop == true ? 0 : 40,
        //     height: isOnTop == true ? 0 : 40,
        //     decoration: BoxDecoration(
        //       color: _theme.canvasColor,
        //       shape: BoxShape.circle,
        //     ),
        //     padding: EdgeInsets.zero,
        //     margin: EdgeInsets.zero,
        //     child: ClipOval(
        //       child: Material(
        //         color: Colors.transparent,
        //         child: SizedBox(
        //           height: 40,
        //           width: 40,
        //           child: Center(
        //             child: IconButton(
        //               padding: EdgeInsets.zero,
        //               onPressed: () {
        //                 scrollController
        //                     .animateTo(
        //                   scrollController.position.minScrollExtent,
        //                   duration: const Duration(milliseconds: 500),
        //                   curve: Curves.easeIn,
        //                 )
        //                     .then((value) {
        //                   if (mounted) {
        //                     setState(() {
        //                       isOnTop = true;
        //                       isScrollingDown = false;
        //                     });
        //                   }
        //                   show();
        //                 });
        //               },
        //               icon: Icon(
        //                 Icons.arrow_upward_rounded,
        //                 color: widget.unselectedColor,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: widget.start,
          child: SlideTransition(
            position: _offsetAnimation,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2.0,
                  sigmaY: 2.0,
                ),
                child: SizedBox(
                  width: _navbarWidth,
                  height: 70,
                  child: Material(
                    color: _theme.colorScheme.onSurface.withOpacity(0.4),
                    child: Row(
                      children: [
                        Expanded(
                          child: TabBar(
                            indicatorPadding:
                                const EdgeInsets.fromLTRB(6, 0, 6, 0),
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                color: _theme.primaryColor,
                                width: 4,
                              ),
                              insets: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                            ),
                            tabs: widget.tabs
                                .asMap()
                                .map(
                                  (index, tab) => MapEntry(
                                    index,
                                    Tooltip(
                                      message: tab.text,
                                      triggerMode: TooltipTriggerMode.longPress,
                                      child: Center(
                                        child: Icon(
                                          tab.icon,
                                          color: _tabController!.index == index
                                              ? widget.color
                                              : widget.unselectedColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .values
                                .toList(),
                          ),
                        ),
                        if (widget.actions != null)
                          const VerticalDivider(
                            color: Colors.white70,
                            indent: 8,
                            endIndent: 8,
                            width: 0,
                          ),
                        if (widget.actions != null)
                          ...widget.actions!.map(
                            (action) => InkWell(
                              onTap: action.onTap,
                              child: Container(
                                height: double.infinity,
                                width: actionButtonWidth,
                                padding: const EdgeInsetsDirectional.only(
                                  start: 24,
                                  end: 24,
                                ),
                                child: DefaultTextStyle(
                                  style: (tabBarTheme.labelStyle ??
                                          _theme.primaryTextTheme.bodyText1)!
                                      .copyWith(
                                    color: widget.unselectedColor,
                                  ),
                                  child: IconTheme.merge(
                                    data: IconThemeData(
                                      size: 24.0,
                                      color: widget.unselectedColor,
                                    ),
                                    child: action.child,
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
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class InheritedDataProvider extends InheritedWidget {
  final ScrollController scrollController;

  const InheritedDataProvider({
    super.key,
    required Widget child,
    required this.scrollController,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedDataProvider oldWidget) =>
      scrollController != oldWidget.scrollController;

  static InheritedDataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedDataProvider>()!;
}
