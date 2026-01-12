import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../common/service/calendar_service.dart';
import '../../data/enums/calendar_view_mode.dart';
import '../../data/model/event_model.dart';
import '../../data/repository/home_repository.dart';
import '../blocs/event_bloc/event_bloc.dart';
import '../screen/home_screen.dart';

abstract class HomeScreenState extends State<HomeScreen> {
  late final EventBloc eventBloc;
  late DateTime currentDate;
  late DateTime? selectedDate;
  late final CalendarService calendarService;
  CalendarViewMode viewMode = CalendarViewMode.month;
  final years = List.generate(2950 - 1950 + 1, (i) => 1950 + i);

  List<String> get months => const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  List<String> get weekDays => const ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];

  void onPrevious() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + 1);
      selectedDate = DateTime(currentDate.year, currentDate.month, 1);
    });

    eventBloc
      ..add(FilterByDate(selectedDate!))
      ..add(ClearFilter());
  }

  void onNext() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month - 1);

      selectedDate = DateTime(currentDate.year, currentDate.month, 1);
    });

    eventBloc
      ..add(FilterByDate(selectedDate!))
      ..add(ClearFilter());
  }

  void onDaySelected(DateTime date) {
    setState(() => selectedDate = date);
    eventBloc.add(FilterByDate(date));
  }

  Map<String, String> monthMap = {
    'января': 'January',
    'февраля': 'February',
    'марта': 'March',
    'апреля': 'April',
    'мая': 'May',
    'июня': 'June',
    'июля': 'July',
    'августа': 'August',
    'сентября': 'September',
    'октября': 'October',
    'ноября': 'November',
    'декабря': 'December',
  };

  String formattedDate() {
    final date = selectedDate ?? DateTime.now();

    var text = DateFormat('d MMMM yyyy').format(date);

    monthMap.forEach((ru, en) {
      if (text.contains(ru)) {
        text = text.replaceAll(ru, en);
      }
    });

    return text;
  }

  String todayWeekday() {
    const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    final now = DateTime.now();
    return days[now.weekday % 7];
  }

  Map<DateTime, List<Color>> buildEventDots(List<EventModel> events) {
    final map = <DateTime, List<Color>>{};

    for (final e in events) {
      final key = DateTime(e.startTime.year, e.startTime.month, e.startTime.day);

      map.putIfAbsent(key, () => []);
      map[key]!.add(e.color);
    }

    return map;
  }

  void openYearView() {
    setState(() => viewMode = CalendarViewMode.year);
  }

  void openMonthView(int year) {
    setState(() {
      final base = selectedDate ?? DateTime.now();

      selectedDate = DateTime(year, base.month, base.day);

      currentDate = DateTime(year, base.month);

      viewMode = CalendarViewMode.month;
    });

    eventBloc.add(FilterByDate(selectedDate!));
  }

  @override
  void initState() {
    super.initState();
    eventBloc = EventBloc(EventRepositoryImpl(Database()))..add(GetEvent());
    currentDate = DateTime.now();
    selectedDate = DateTime.now();
    calendarService = CalendarService();
  }
}
