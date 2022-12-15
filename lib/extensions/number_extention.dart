import 'package:flutter/foundation.dart';

extension NumberExtention on num {
  static String __round(double number, int fixed) {
    return number.toStringAsFixed(fixed).replaceAllMapped(
      RegExp(r'\.?[0]+$'),
      (match) {
        return '';
      },
    );
  }

  String secondsToMmSs() {
    String minutes = ((this ~/ 60) % 60).toString().padLeft(2, '0');
    String seconds = (this % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  String? humanReadableNumber({int fixed = 2}) {
    try {
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      if (this < 1000) {
        // less than a thousend
        return toString();
      } else if (this > 1000 && this < 1000000) {
        // less than a million
        double result = this / 1000;
        return '${__round(result, fixed)} K';
      } else if (this >= 1000000 && this < (1000000 * 10 * 100)) {
        // less than 100 million
        double result = this / 1000000;
        return '${__round(result, fixed)} M';
      } else if (this >= (1000000 * 10 * 100) &&
          this < (1000000 * 10 * 100 * 100)) {
        // less than 100 billion
        double result = this / (1000000 * 10 * 100);
        return '${__round(result, fixed)} B';
      } else if (this >= (1000000 * 10 * 100 * 100) &&
          this < (1000000 * 10 * 100 * 100 * 100)) {
        // less than 100 trillion
        double result = this / (1000000 * 10 * 100 * 100);
        return '${__round(result, fixed)} T';
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return '-';
  }
}
