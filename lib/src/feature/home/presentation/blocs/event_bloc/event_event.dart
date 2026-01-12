part of 'event_bloc.dart';

sealed class EventBlocEvent {}

final class GetEvent extends EventBlocEvent {}

class ClearFilter extends EventBlocEvent {}

class FilterByDate extends EventBlocEvent {
  FilterByDate(this.date);
  final DateTime date;
}

class AddEvent extends EventBlocEvent {
  AddEvent(this.event);
  final EventModel event;
}

class UpdateEvent extends EventBlocEvent {
  UpdateEvent(this.event);
  final EventModel event;
}

class DeleteEvent extends EventBlocEvent {
  DeleteEvent(this.id);
  final int id;
}
