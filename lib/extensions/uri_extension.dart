import 'package:flutter/material.dart';
import 'package:beautiful_destinations/extensions/string_extension.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

extension UriExtension on Uri {
  void tryLaunch([
    String? copyOnError,
    BuildContext? context,
  ]) {
    var errorMsg =
        "I can not launch the url, So i copied it into your clipboard";

    canLaunchUrl(this).then(
      (can) {
        if (can) {
          launchUrl(this).then(
            (successful) {
              if (successful == true) return;
              copyOnError?.copyToClipboard();
              if (context != null) errorMsg.showSnackBar(context);
            },
          ).onError(
            (error, stackTrace) {
              copyOnError?.copyToClipboard();
              if (context != null) errorMsg.showSnackBar(context);
            },
          );
        } else {
          copyOnError?.copyToClipboard();
          if (context != null) errorMsg.showSnackBar(context);
        }
      },
    ).onError(
      (error, stackTrace) {
        copyOnError?.copyToClipboard();
        if (context != null) errorMsg.showSnackBar(context);
      },
    );
  }
}

extension StringUriExtension on String {
  void tryLaunch([
    String? copyOnError,
    BuildContext? context,
  ]) {
    var errorMsg =
        "I can not launch the link, So i copied it into your clipboard";

    canLaunchUrlString(this).then(
      (can) {
        if (can) {
          launchUrlString(this).then(
            (successful) {
              if (successful == true) return;
              copyOnError?.copyToClipboard();
              if (context != null) errorMsg.showSnackBar(context);
            },
          ).onError(
            (error, stackTrace) {
              copyOnError?.copyToClipboard();
              if (context != null) errorMsg.showSnackBar(context);
            },
          );
        } else {
          copyOnError?.copyToClipboard();
          if (context != null) errorMsg.showSnackBar(context);
        }
      },
    ).onError(
      (error, stackTrace) {
        copyOnError?.copyToClipboard();
        if (context != null) errorMsg.showSnackBar(context);
      },
    );
  }
}
