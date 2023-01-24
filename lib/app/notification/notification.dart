import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationView extends StatelessWidget {
  static const routeName = '/notification';

  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.notifications),
        elevation: 0,
        backgroundColor: theme.canvasColor,
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32.0,
                    bottom: 8,
                    left: 24,
                    right: 24,
                  ),
                  child: Text(
                    localizations.today,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: NotificationItem(
                      icon: Icons.ac_unit_rounded,
                      text: "Your booking request",
                      caption:
                          "In publishing and graphic design, Lorem ipsum is a",
                      active: true,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: NotificationItem(
                      icon: Icons.home,
                      iconBackgroundColor: Colors.green.shade700,
                      text: "Get 10% offer rent room",
                      caption:
                          "In publishing and graphic design, Lorem ipsum is a",
                      active: true,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: NotificationItem(
                      icon: Icons.flight_takeoff_rounded,
                      iconBackgroundColor: Colors.yellow.shade700,
                      text: "Your flight is ready to take off!",
                      caption:
                          "In publishing and graphic design, Lorem ipsum is a",
                      active: true,
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
                    localizations.thisWeek,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: NotificationItem(
                      icon: Icons.bus_alert,
                      iconBackgroundColor: Colors.purple.shade700,
                      text: "Your bus stopped!",
                      caption:
                          "In publishing and graphic design, Lorem ipsum is a",
                      active: false,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: NotificationItem(
                      icon: Icons.calendar_month,
                      iconBackgroundColor: Colors.orange.shade700,
                      text: "Get 25% offer rent room",
                      caption:
                          "In publishing and graphic design, Lorem ipsum is a",
                      active: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String text;
  final String? caption;
  final bool active;

  const NotificationItem({
    super.key,
    required this.icon,
    required this.text,
    this.caption,
    this.iconColor = Colors.white,
    this.iconBackgroundColor = const Color(0xFF283593),
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBackgroundColor,
            ),
            width: 64,
            height: 64,
            child: Icon(
              icon,
              color: iconColor,
              size: 32,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 24, end: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                  ),
                  if (caption != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        caption!,
                        style: theme.textTheme.caption,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (active)
            Container(
              margin: const EdgeInsetsDirectional.only(start: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.shade700,
              ),
              width: 8,
              height: 8,
            ),
        ],
      ),
    );
  }
}
