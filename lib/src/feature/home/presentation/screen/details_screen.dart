import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../common/constant/gen/assets.gen.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/router/routes.dart';
import '../../../../common/util/dimension.dart';
import '../blocs/event_bloc/event_bloc.dart';
import '../state/details_screen_state.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({required this.eventId, super.key});

  final int eventId;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends DetailsScreenState {
  @override
  Widget build(BuildContext context) => BlocBuilder<EventBloc, EventBlocState>(
    builder: (context, state) {
      final event = state.allEvents.firstWhere((e) => e.id == widget.eventId);

      return Scaffold(
        backgroundColor: context.color.white,

        appBar: AppBar(
          backgroundColor: event.color,
          leadingWidth: 64,
          leading: Padding(
            padding: Dimension.pLeft20,
            child: InkWell(
              onTap: () => context.pop(),
              child: SizedBox(
                width: 40,
                height: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: context.color.white, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back_ios_new, size: 20),
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: Dimension.pRight22,
              child: InkWell(
                onTap: () {
                  context.push(
                    AddPage(eventBloc: context.read<EventBloc>(), selectedDate: event.startTime, event: event),
                  );
                },
                child: Row(
                  children: [
                    Assets.icons.edit.svg(width: 14, height: 14),
                    const SizedBox(width: 4),
                    Text('Edit', style: context.textTheme.workSansW400s14.copyWith(color: context.color.white)),
                  ],
                ),
              ),
            ),
          ],
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: event.color, borderRadius: Dimension.rBottom16),
                child: Padding(
                  padding: Dimension.pAll24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title, style: context.textTheme.workSansW600s26.copyWith(color: context.color.white)),
                      Text(
                        event.subtitle,
                        style: context.textTheme.workSansW400s10.copyWith(color: context.color.white),
                      ),
                      Dimension.hBox12,
                      Row(
                        children: [
                          Assets.vectors.time.svg(
                            width: 18,
                            height: 18,
                            colorFilter: ColorFilter.mode(context.color.white, BlendMode.srcATop),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${DateFormat('HH:mm').format(event.startTime)} - "
                            "${DateFormat('HH:mm').format(event.endTime)}",
                            style: context.textTheme.workSansW400s10.copyWith(color: context.color.white),
                          ),
                        ],
                      ),
                      Dimension.hBox12,
                      Row(
                        children: [
                          Assets.vectors.location.svg(
                            width: 18,
                            height: 18,
                            colorFilter: ColorFilter.mode(context.color.white, BlendMode.srcATop),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            event.location,
                            style: context.textTheme.workSansW400s10.copyWith(color: context.color.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: Dimension.pAll24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reminder', style: context.textTheme.workSansW600s16),
                  Dimension.hBox10,
                  Text(
                    '15 minutes before',
                    style: context.textTheme.workSansW400s16.copyWith(color: context.color.grey50),
                  ),
                  Dimension.hBox22,
                  Text('Description', style: context.textTheme.workSansW600s16),
                  Dimension.hBox10,
                  Text(
                    event.description,
                    style: context.textTheme.workSansW400s16.copyWith(color: context.color.grey50),
                  ),
                ],
              ),
            ),
          ],
        ),

        bottomNavigationBar: Padding(
          padding: Dimension.pAll16.copyWith(bottom: 40),
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: context.color.red, borderRadius: Dimension.rAll10),
                child: Padding(
                  padding: Dimension.pV16,
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      Assets.icons.delete.svg(width: 20, height: 20),
                      const SizedBox(width: 4),
                      Text('Delete Event', style: context.textTheme.workSansW600s14),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
