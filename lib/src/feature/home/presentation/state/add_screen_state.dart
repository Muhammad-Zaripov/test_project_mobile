import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../common/extension/context_extension.dart';
import '../../data/enums/event_status.dart';
import '../../data/model/event_model.dart';
import '../blocs/event_bloc/event_bloc.dart';
import '../screen/add_screen.dart';

abstract class AddScreenState extends State<AddScreen> {
  late final TextEditingController titleController;
  late final TextEditingController subtitleController;
  late final TextEditingController descriptionController;
  late final TextEditingController locationController;
  late final TextEditingController timeController;
  late EventStatus selectedStatus;
  late final Database db;

  DateTime parseEndTime(String input) {
    final now = DateTime.now();
    final parts = input.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  Future<void> onAddTap() async {
    if (!timeController.text.contains(':')) return;

    final endTime = parseEndTime(timeController.text);

    final startTime = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
      widget.event?.startTime.hour ?? DateTime.now().hour,
      widget.event?.startTime.minute ?? DateTime.now().minute,
    );

    final event = EventModel(
      id: widget.event?.id,

      title: titleController.text,
      subtitle: subtitleController.text,
      description: descriptionController.text,
      location: locationController.text,
      status: selectedStatus,
      color: selectedStatus.color,
      startTime: startTime,
      endTime: endTime,
    );

    if (widget.isEdit) {
      context.read<EventBloc>().add(UpdateEvent(event));
    } else {
      context.read<EventBloc>().add(AddEvent(event));
    }
    if (mounted) context.pop();
  }

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.event?.title ?? '');
    subtitleController = TextEditingController(text: widget.event?.subtitle ?? '');
    descriptionController = TextEditingController(text: widget.event?.description ?? '');
    locationController = TextEditingController(text: widget.event?.location ?? '');
    timeController = TextEditingController(
      text: widget.event != null ? DateFormat('HH:mm').format(widget.event!.endTime) : '',
    );

    selectedStatus = widget.event?.status ?? EventStatus.danger;
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    timeController.dispose();
    super.dispose();
  }
}
