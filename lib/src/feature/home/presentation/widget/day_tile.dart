import 'package:flutter/material.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/service/calendar_service.dart';
import '../../../../common/util/dimension.dart';

class DayTile extends StatelessWidget {
  const DayTile({
    required this.day,
    required this.currentDate,
    required this.selectedDate,
    required this.calendarService,
    required this.onDaySelected,
    required this.dots,
    super.key,
  });

  final int day;
  final DateTime currentDate;
  final DateTime? selectedDate;
  final CalendarService calendarService;
  final ValueChanged<DateTime> onDaySelected;
  final List<Color> dots;

  @override
  Widget build(BuildContext context) {
    final date = DateTime(currentDate.year, currentDate.month, day);

    final isSelected = selectedDate != null && calendarService.isSameDay(date, selectedDate!);

    return GestureDetector(
      onTap: () => onDaySelected(date),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: .circle,
              color: isSelected ? context.color.blue : context.color.transparent,
            ),
            alignment: .center,
            child: Text('$day', style: TextStyle(color: isSelected ? context.color.white : context.color.black)),
          ),
          Dimension.hBox4,
          if (dots.isNotEmpty)
            Row(
              mainAxisAlignment: .center,
              children: dots
                  .toSet()
                  .take(3)
                  .map(
                    (c) => SizedBox(
                      width: 6,
                      height: 6,
                      child: Padding(
                        padding: Dimension.pAll1,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: c, shape: .circle),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
