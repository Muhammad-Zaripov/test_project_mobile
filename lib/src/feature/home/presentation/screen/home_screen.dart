import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/constant/gen/assets.gen.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/router/routes.dart';
import '../../../../common/util/dimension.dart';
import '../../data/enums/calendar_view_mode.dart';
import '../blocs/event_bloc/event_bloc.dart';
import '../state/home_screen_state.dart';
import '../widget/calendar_grid.dart';
import '../widget/calendar_header.dart';
import '../widget/event_list.dart';
import '../widget/week_days_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeScreenState {
  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: eventBloc,
    child: Scaffold(
      backgroundColor: context.color.white,

      appBar: AppBar(
        leading: viewMode == CalendarViewMode.month
            ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: openYearView)
            : null,
        centerTitle: true,
        actions: [Padding(padding: Dimension.pRight16, child: Assets.vectors.notification.svg(width: 28, height: 24))],
        backgroundColor: context.color.white,
        title: Text(
          viewMode == CalendarViewMode.month ? todayWeekday() : 'Select Year',
          style: context.textTheme.workSansW600s14,
        ),
      ),

      body: viewMode == CalendarViewMode.month ? _buildMonthView(context) : _buildYearView(context),
    ),
  );

  Widget _buildMonthView(BuildContext context) => Padding(
    padding: Dimension.pAll16,
    child: Column(
      children: [
        CalendarHeader(currentDate: currentDate, months: months, onPrevious: onPrevious, onNext: onNext),
        Dimension.hBox20,
        WeekDaysRow(weekDays: weekDays),
        BlocBuilder<EventBloc, EventBlocState>(
          builder: (context, state) {
            final dots = buildEventDots(state.allEvents);
            return CalendarGrid(
              currentDate: currentDate,
              selectedDate: selectedDate,
              calendarService: calendarService,
              onDaySelected: onDaySelected,
              eventDots: dots,
            );
          },
        ),
        Dimension.hBox20,
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text('Schedule', style: context.textTheme.workSansW600s14),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: context.color.blue,
                shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll10),
              ),
              onPressed: () {
                context.push(AddPage(eventBloc: eventBloc, selectedDate: selectedDate!));
              },
              child: const Text('+ Add Event'),
            ),
          ],
        ),
        Dimension.hBox24,
        const Expanded(child: EventList()),
      ],
    ),
  );

  Widget _buildYearView(BuildContext context) => BlocBuilder<EventBloc, EventBlocState>(
    builder: (context, state) {
      final yearCounts = <int, int>{};
      for (final e in state.allEvents) {
        yearCounts.update(e.startTime.year, (v) => v + 1, ifAbsent: () => 1);
      }

      return Padding(
        padding: Dimension.pAll16,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.2,
          ),
          itemCount: 2950 - 1950 + 1,
          itemBuilder: (context, index) {
            final year = 1950 + index;
            final count = yearCounts[year] ?? 0;
            return InkWell(
              borderRadius: Dimension.rAll12,
              onTap: () => openMonthView(year),
              child: DecoratedBox(
                decoration: BoxDecoration(color: context.color.grey, borderRadius: Dimension.rAll12),
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Text(year.toString(), style: context.textTheme.workSansW600s16),
                    if (count > 0) ...[
                      Dimension.hBox4,
                      Text('$count events', style: context.textTheme.workSansW400s12),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
