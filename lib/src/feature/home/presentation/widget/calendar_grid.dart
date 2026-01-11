import 'package:flutter/material.dart';
import '../../../../common/service/calendar_service.dart';
import 'day_tile.dart';

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({
    required this.currentDate,
    required this.selectedDate,
    required this.calendarService,
    required this.onDaySelected,
    required this.eventDots,
    super.key,
  });

  final DateTime currentDate;
  final DateTime? selectedDate;
  final CalendarService calendarService;
  final ValueChanged<DateTime> onDaySelected;
  final Map<DateTime, List<Color>> eventDots;

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;

    final firstDay = DateTime(currentDate.year, currentDate.month, 1).weekday % 7;

    final widgets = <Widget>[];

    for (var i = 0; i < firstDay; i++) {
      widgets.add(const SizedBox());
    }

    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(currentDate.year, currentDate.month, day);

      widgets.add(
        DayTile(
          day: day,
          currentDate: currentDate,
          selectedDate: selectedDate,
          calendarService: calendarService,
          onDaySelected: onDaySelected,
          dots: eventDots[date] ?? [],
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.8,
      children: widgets,
    );
  }
}
