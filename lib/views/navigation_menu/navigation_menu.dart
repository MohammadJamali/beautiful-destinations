import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationMenu extends StatelessWidget {
  static const routeName = '/navigation';

  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
        elevation: 0,
        backgroundColor: theme.canvasColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32),
              child: ListTile(
                leading: const Icon(Icons.translate_rounded),
                title: Text(localizations.languages),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            const Divider(indent: 24, endIndent: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
              child: ListTile(
                leading: const Icon(Icons.notifications_none_rounded),
                title: Text(localizations.notificationSettings),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            const Divider(indent: 24, endIndent: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
              child: ListTile(
                leading: const Icon(Icons.shield_outlined),
                title: Text(localizations.termsAndConditions),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            const Divider(indent: 24, endIndent: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
              child: ListTile(
                leading: const Icon(Icons.lock_outline_rounded),
                title: Text(localizations.privacy),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            const Divider(indent: 24, endIndent: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
              child: ListTile(
                leading: const Icon(Icons.support_agent_rounded),
                title: Text(localizations.helpCenter),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            const Divider(indent: 24, endIndent: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
              child: ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: Text(localizations.logout),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            const Divider(indent: 24, endIndent: 24),
          ],
        ),
      ),
    );
  }
}
