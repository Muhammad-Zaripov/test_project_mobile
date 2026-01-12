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
    this.isPreviousMonth = false,
    this.isNextMonth = false,
  });

  final int day;
  final bool isPreviousMonth;
  final bool isNextMonth;
  final DateTime currentDate;
  final DateTime? selectedDate;
  final CalendarService calendarService;
  final ValueChanged<DateTime> onDaySelected;
  final List<Color> dots;

  @override
  Widget build(BuildContext context) {
    final date = isPreviousMonth
        ? DateTime(currentDate.year, currentDate.month - 1, day)
        : isNextMonth
        ? DateTime(currentDate.year, currentDate.month + 1, day)
        : DateTime(currentDate.year, currentDate.month, day);

    final isToday = calendarService.isSameDay(date, DateTime.now());
    final isSelected = selectedDate != null && calendarService.isSameDay(date, selectedDate!);
    final isCurrentMonth = !isPreviousMonth && !isNextMonth;

    return GestureDetector(
      onTap: isCurrentMonth ? () => onDaySelected(date) : null,
      child: Opacity(
        opacity: isCurrentMonth ? 1 : 0.35,
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: .circle,
                color: isSelected ? context.color.blue : Colors.transparent,
                border: isToday && !isSelected ? Border.all(color: context.color.blue, width: 1) : null,
              ),
              alignment: .center,
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : context.color.black,
                  fontWeight: isToday ? .w600 : .w400,
                ),
              ),
            ),
            Dimension.hBox4,
            if (dots.isNotEmpty)
              Row(
                spacing: 2,
                mainAxisAlignment: .center,
                children: dots
                    .take(3)
                    .map(
                      (c) => SizedBox(
                        width: 5,
                        height: 5,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: c, shape: .circle),
                        ),
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
