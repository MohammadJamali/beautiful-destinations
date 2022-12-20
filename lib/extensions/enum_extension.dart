import 'map_extension.dart';
import 'string_extension.dart';
import 'uri_extension.dart';

import 'dart:io' show Platform;
import 'dart:ui' show SingletonFlutterWindow;

import 'package:flutter/material.dart'
    show BuildContext, IconData, MediaQueryData;

// import 'package:font_awesome_flutter/font_awesome_flutter.dart'
//     show FontAwesomeIcons, IconDataBrands, IconDataRegular, IconDataSolid;
import 'package:beautiful_destinations/repositories/models/enums/contact_host.dart'
    show ContactHost;
import 'package:beautiful_destinations/repositories/models/enums/icon_class.dart'
    show IconClass;

import 'package:flutter/widgets.dart'
    show BuildContext, IconData, MediaQueryData;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:beautiful_destinations/repositories/models/enums/screen_type.dart';

extension IconClassExtension on IconClass {
  // NOTE:
  // iconClass!.iconData(xxx)
  // Class 'IconClass' has no instance method 'iconData'.
  //
  // USE:
  // (post.iconClass! as IconClass).iconData
  //
  // :|
  IconData iconData(int code) {
    switch (this) {
      // case IconClass.iconDataSolid:
      //   return IconDataSolid(code);
      // case IconClass.iconDataBrands:
      //   return IconDataBrands(code);
      // case IconClass.iconDataRegular:
      //   return IconDataRegular(code);
      case IconClass.materialIcon:
        return IconData(code, fontFamily: 'MaterialIcons');
      default:
        throw Exception();
    }
  }
}

extension ContactHostExtention on ContactHost {
//   IconData get icon {
//     switch (this) {
//       case ContactHost.phone:
//         return FontAwesomeIcons.phone;

//       case ContactHost.sms:
//         return FontAwesomeIcons.commentSms;

//       case ContactHost.email:
//         return FontAwesomeIcons.solidEnvelope;

//       case ContactHost.facebook:
//         return FontAwesomeIcons.facebook;

//       case ContactHost.instagram:
//         return FontAwesomeIcons.instagram;

//       case ContactHost.telegram:
//         return FontAwesomeIcons.telegram;

//       case ContactHost.whatsapp:
//         return FontAwesomeIcons.whatsapp;

//       case ContactHost.skype:
//         return FontAwesomeIcons.skype;

//       case ContactHost.pinterest:
//         return FontAwesomeIcons.pinterest;

//       case ContactHost.twitter:
//         return FontAwesomeIcons.twitter;

//       case ContactHost.twitch:
//         return FontAwesomeIcons.twitch;

//       case ContactHost.viber:
//         return FontAwesomeIcons.viber;

//       case ContactHost.youtube:
//         return FontAwesomeIcons.youtube;

//       case ContactHost.linkedIn:
//         return FontAwesomeIcons.linkedin;

//       case ContactHost.medium:
//         return FontAwesomeIcons.medium;
//     }
//   }

  String format(String identifier) {
    switch (this) {
      case ContactHost.instagram:
      case ContactHost.telegram:
      case ContactHost.twitter:
      case ContactHost.twitch:
      case ContactHost.whatsapp:
        return !identifier.startsWith('@') ? '@$identifier' : identifier;
      default:
        return identifier;
    }
  }

  Function(BuildContext, AppLocalizations) intraction(String identifier) {
    switch (this) {
      case ContactHost.email:
        return (BuildContext context, AppLocalizations localizations) {
          Uri(
            scheme: 'mailto',
            path: identifier,
          ).tryLaunch(identifier, context);
        };
      case ContactHost.phone:
        return (BuildContext context, AppLocalizations localizations) {
          var tel = Uri(scheme: 'tel', path: identifier);
          tel.tryLaunch(identifier, context);
        };
      case ContactHost.sms:
        return (BuildContext context, AppLocalizations localizations) {
          var tel = Uri(scheme: 'sms', path: identifier);
          tel.tryLaunch(identifier, context);
        };
      case ContactHost.whatsapp:
        return (BuildContext context, AppLocalizations localizations) {
          if (Platform.isAndroid || Platform.isIOS) {
            Uri(
              scheme: Platform.isAndroid ? 'intent' : 'whatsapp',
              path: 'send',
              query: <String, String>{
                'phone': identifier,
              }.encodeQueryParameters(),
            ).tryLaunch(identifier, context);
          } else {
            'https://api.whatsapp.com/send?phone=$identifier'
                .tryLaunch(identifier, context);
          }
        };
      case ContactHost.telegram:
        var userId = int.tryParse(identifier);
        if (userId != null) {
          return (BuildContext context, AppLocalizations localizations) {
            Uri(
              scheme: 'tg',
              path: 'openmessage',
              query: <String, String>{'user_id': '$userId'}
                  .encodeQueryParameters(),
            ).tryLaunch();
          };
        } else {
          return (BuildContext context, AppLocalizations localizations) {
            'https://t.me/$identifier'.tryLaunch(identifier, context);
          };
        }
      case ContactHost.instagram:
        return (BuildContext context, AppLocalizations localizations) {
          'https://instagram.com/$identifier'.tryLaunch(identifier, context);
        };
      case ContactHost.linkedIn:
        return (BuildContext context, AppLocalizations localizations) {
          'https://linkedin.com/in/$identifier'.tryLaunch(identifier, context);
        };
      case ContactHost.medium:
        return (BuildContext context, AppLocalizations localizations) {
          'https://medium.com/@$identifier'.tryLaunch(identifier, context);
        };
      default:
        return (BuildContext context, AppLocalizations localizations) =>
            identifier.copyToClipboard();
    }
  }

  String localize(AppLocalizations localizations) {
    switch (this) {
      case ContactHost.phone:
        return localizations.phone;
      case ContactHost.sms:
        return localizations.sms;
      case ContactHost.email:
        return localizations.email;
      case ContactHost.facebook:
        return localizations.facebook;
      case ContactHost.instagram:
        return localizations.instagram;
      case ContactHost.telegram:
        return localizations.telegram;
      case ContactHost.whatsapp:
        return localizations.whatsapp;
      case ContactHost.skype:
        return localizations.skype;
      case ContactHost.pinterest:
        return localizations.pinterest;
      case ContactHost.twitter:
        return localizations.twitter;
      case ContactHost.twitch:
        return localizations.twitch;
      case ContactHost.viber:
        return localizations.viber;
      case ContactHost.youtube:
        return localizations.youTube;
      case ContactHost.linkedIn:
        return localizations.linkedIn;
      case ContactHost.medium:
        return localizations.medium;
    }
  }
}

extension ScreenSizeExtension on MediaQueryData {
  ScreenType getScreenType() {
    var screenType = ScreenType.extraLarge;
    if (size.width < 768) {
      screenType = ScreenType.small;
    } else if (size.width < 992) {
      screenType = ScreenType.medium;
    } else if (size.width < 1200) {
      screenType = ScreenType.large;
    }

    return screenType;
  }

  int getAppWidth() {
    switch (getScreenType()) {
      case ScreenType.small:
        return 300;
      case ScreenType.medium:
        return 400;
      case ScreenType.large:
        return 500;
      case ScreenType.extraLarge:
        return 600;
    }
  }
}

extension FlutterWindowExtension on SingletonFlutterWindow {
  ScreenType getScreenType() {
    var screenType = ScreenType.extraLarge;
    if (physicalSize.width < 768) {
      screenType = ScreenType.small;
    } else if (physicalSize.width < 992) {
      screenType = ScreenType.medium;
    } else if (physicalSize.width < 1200) {
      screenType = ScreenType.large;
    }

    return screenType;
  }

  double getAppWidth() {
    switch (getScreenType()) {
      case ScreenType.small:
        return 400;
      case ScreenType.medium:
        return 400;
      case ScreenType.large:
        return 500;
      case ScreenType.extraLarge:
        return 600;
    }
  }
}
