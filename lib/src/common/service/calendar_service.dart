typedef OnDateSelected = void Function(DateTime date);

class CalendarService {
  bool isSameDay(DateTime d1, DateTime d2) => d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
}
