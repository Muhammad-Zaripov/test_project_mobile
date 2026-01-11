import 'package:flutter/material.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/util/dimension.dart';
import '../../data/enums/event_status.dart';
import '../../data/model/event_model.dart';
import '../state/add_screen_state.dart';
import '../widget/custom_text_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({required this.selectedDate, super.key, this.event});
  final DateTime selectedDate;
  final EventModel? event;
  bool get isEdit => event != null;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends AddScreenState {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.color.white,
    appBar: AppBar(backgroundColor: context.color.white),
    body: SingleChildScrollView(
      padding: Dimension.pAll16,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const Text('Event name'),
          CustomTextField(controller: titleController),
          Dimension.hBox16,
          const Text('Subtitle'),
          CustomTextField(controller: subtitleController),
          Dimension.hBox16,
          const Text('Description'),
          CustomTextField(controller: descriptionController, minLines: 4, maxLines: 4),
          Dimension.hBox16,
          const Text('Location'),
          CustomTextField(controller: locationController, location: true),
          Dimension.hBox16,
          const Text('Priority color'),
          Dimension.hBox4,
          SizedBox(
            width: 90,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(color: context.color.grey, borderRadius: Dimension.rAll8),
              child: Row(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: DecoratedBox(decoration: BoxDecoration(color: selectedStatus.color.withValues(alpha: 0.2))),
                  ),

                  PopupMenuButton<EventStatus>(
                    padding: .zero,
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    iconSize: 20,
                    iconColor: context.color.blue,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    onSelected: (v) => setState(() => selectedStatus = v),
                    itemBuilder: (_) => EventStatus.values
                        .map(
                          (e) => PopupMenuItem<EventStatus>(
                            value: e,
                            height: 36,
                            child: Row(
                              spacing: 8,
                              children: [
                                Container(width: 16, height: 16, decoration: BoxDecoration(color: e.color)),
                                Text(e.name),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),

          Dimension.hBox16,
          const Text('Time (HH:mm)'),
          CustomTextField(controller: timeController),
        ],
      ),
    ),
    bottomNavigationBar: Padding(
      padding: Dimension.pAll16.copyWith(bottom: 40),
      child: InkWell(
        onTap: onAddTap,
        child: DecoratedBox(
          decoration: BoxDecoration(color: context.color.blue, borderRadius: Dimension.rAll8),
          child: Padding(
            padding: Dimension.pAll10,
            child: Text(
              widget.isEdit ? 'Update' : 'Add',
              textAlign: .center,
              style: context.textTheme.workSansW400s16.copyWith(color: context.color.white),
            ),
          ),
        ),
      ),
    ),
  );
}
