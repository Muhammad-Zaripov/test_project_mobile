import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/util/dimension.dart';
import '../blocs/event_bloc/event_bloc.dart';
import 'event_card.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<EventBloc, EventBlocState>(
    builder: (context, state) => switch (state.status) {
      .loading => const Center(child: CircularProgressIndicator()),
      .success =>
        state.events.isEmpty
            ? const Center(child: Text('No Task'))
            : ListView.builder(
                itemCount: state.events.length,
                itemBuilder: (context, index) => Padding(
                  padding: Dimension.pBottom12,
                  child: EventCard(event: state.events[index], onRemove: () {}),
                ),
              ),
      _ => const SizedBox(),
    },
  );
}
