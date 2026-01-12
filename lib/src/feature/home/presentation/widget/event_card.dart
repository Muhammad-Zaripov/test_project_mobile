import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../common/constant/gen/assets.gen.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/router/routes.dart';
import '../../../../common/util/dimension.dart';
import '../../data/model/event_model.dart';
import '../blocs/event_bloc/event_bloc.dart';

class EventCard extends StatelessWidget {
  const EventCard({required this.event, required this.onRemove, super.key});
  final EventModel event;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      context.push(DetailPage(eventBloc: context.read<EventBloc>(), eventId: event.id!));
    },

    child: Stack(
      children: [
        SizedBox(
          width: .infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(color: event.color.withValues(alpha: 0.2), borderRadius: Dimension.rAll10),

            child: Padding(
              padding: Dimension.pAll12.copyWith(top: 22),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(event.title, style: context.textTheme.workSansW600s14.copyWith(color: event.color)),
                  Text(event.subtitle, style: context.textTheme.workSansW400s10.copyWith(color: event.color)),
                  Dimension.hBox12,
                  Row(
                    spacing: 10,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          Assets.vectors.time.svg(
                            width: 18,
                            height: 18,
                            colorFilter: ColorFilter.mode(event.color, .srcATop),
                          ),
                          Row(
                            children: [
                              Text(
                                "${DateFormat('HH:mm').format(event.startTime)} - ${DateFormat('HH:mm').format(event.endTime)}",
                                style: context.textTheme.workSansW400s10.copyWith(color: event.color),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          Assets.vectors.location.svg(
                            width: 18,
                            height: 18,
                            colorFilter: ColorFilter.mode(event.color, .srcATop),
                          ),
                          Text(event.location, style: context.textTheme.workSansW400s10.copyWith(color: event.color)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: .infinity,
          height: 20,
          child: DecoratedBox(
            decoration: BoxDecoration(color: event.color, borderRadius: Dimension.rTop10),
          ),
        ),
      ],
    ),
  );
}
