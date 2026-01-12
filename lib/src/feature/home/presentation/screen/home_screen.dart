import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/constant/gen/assets.gen.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/router/routes.dart';
import '../../../../common/util/dimension.dart';
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
        actions: [Padding(padding: Dimension.pRight16, child: Assets.icons.notification.svg())],
        centerTitle: true,
        backgroundColor: context.color.white,
        title: Column(
          mainAxisSize: .min,
          children: [
            Text(todayWeekday(), style: context.textTheme.workSansW600s18),
            Dimension.hBox4,
            PopupMenuButton<int>(
              tooltip: '',
              offset: const Offset(0, 36),
              onSelected: openMonthView,
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  enabled: false,
                  child: SizedBox(
                    width: 260,
                    height: 320,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 2.2,
                      ),
                      itemCount: years.length,
                      itemBuilder: (context, index) {
                        final year = years[index];

                        return InkWell(
                          borderRadius: Dimension.rAll8,
                          onTap: () {
                            context.pop();
                            openMonthView(year);
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: context.color.grey, borderRadius: Dimension.rAll8),
                            child: Center(child: Text(year.toString(), style: context.textTheme.workSansW600s14)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],

              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(formattedDate(), style: context.textTheme.workSansW400s14),
                  Dimension.hBox4,
                  const Icon(Icons.keyboard_arrow_down, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),

      body: Padding(
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
      ),
    ),
  );
}
