import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final int maxRate;
  final double rate;

  final Widget filledWidget;
  final Widget halfFilledWidget;
  final Widget emptyWidget;

  const RatingStar({
    super.key,
    required this.maxRate,
    required this.rate,
    // Colors.yellow.shade800
    this.filledWidget = const Icon(
      Icons.star_rate_rounded,
      color: Color(0xFFF9A825),
    ),
    this.halfFilledWidget = const Icon(
      Icons.star_half_rounded,
      color: Color(0xFFF9A825),
    ),
    this.emptyWidget = const Icon(
      Icons.star_rate_rounded,
      color: Colors.grey,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(rate.floor(), (index) => filledWidget),
        if (rate - rate.toInt() > 0) halfFilledWidget,
        ...List.generate((maxRate - rate).floor(), (index) => emptyWidget),
      ],
    );
  }
}
