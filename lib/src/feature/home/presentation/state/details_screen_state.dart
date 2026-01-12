import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/extension/context_extension.dart';
import '../blocs/event_bloc/event_bloc.dart';
import '../screen/details_screen.dart';

abstract class DetailsScreenState extends State<DetailScreen> {
  Future<void> onDeleteTap() async {
    final id = widget.eventId;

    context.read<EventBloc>().add(DeleteEvent(id));

    if (mounted) {
      context.pop();
    }
  }
}
