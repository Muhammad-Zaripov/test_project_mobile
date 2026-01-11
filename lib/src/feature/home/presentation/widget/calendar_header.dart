import 'package:flutter/material.dart';

import '../../../../common/extension/context_extension.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    required this.currentDate,
    required this.months,
    required this.onPrevious,
    required this.onNext,
    super.key,
  });
  final DateTime currentDate;
  final List<String> months;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: .spaceBetween,
    children: [
      Column(
        crossAxisAlignment: .start,
        children: [
          Row(spacing: 8, children: [Text(months[currentDate.month - 1], style: context.textTheme.workSansW400s20)]),
        ],
      ),
      Row(
        spacing: 14,
        children: [
          GestureDetector(
            onTap: onNext,
            child: SizedBox(
              width: 23,
              height: 23,
              child: DecoratedBox(
                decoration: BoxDecoration(color: context.color.grey, shape: .circle),
                child: const Icon(Icons.arrow_back_ios_sharp, size: 12),
              ),
            ),
          ),
          GestureDetector(
            onTap: onPrevious,
            child: SizedBox(
              width: 23,
              height: 23,
              child: DecoratedBox(
                decoration: BoxDecoration(color: context.color.grey, shape: .circle),
                child: const Icon(Icons.arrow_forward_ios_sharp, size: 12),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
