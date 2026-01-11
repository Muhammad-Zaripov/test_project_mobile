import 'package:flutter/material.dart';

import '../../../../common/extension/context_extension.dart';

class WeekDaysRow extends StatelessWidget {
  const WeekDaysRow({required this.weekDays, super.key});
  final List<String> weekDays;

  @override
  Widget build(BuildContext context) => Row(
    children: weekDays
        .map(
          (day) => Expanded(
            child: Center(
              child: Text(day, style: context.textTheme.workSansW400s16.copyWith(color: context.color.grey50)),
            ),
          ),
        )
        .toList(),
  );
}
