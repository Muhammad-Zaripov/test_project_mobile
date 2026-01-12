import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/enum/bloc_status_enum.dart';
import '../../../data/enums/details_model.dart';
import '../../../data/model/event_model.dart';
import '../../../data/repository/home_repository.dart';

part 'event_state.dart';
part 'event_event.dart';

class EventBloc extends Bloc<EventBlocEvent, EventBlocState> {
  EventBloc(this.repository) : super(const EventBlocState()) {
    on<EventBlocEvent>(
      (event, emit) => switch (event) {
        final GetEvent event => _loadEvent(event, emit),
        final FilterByDate event => _filterByDateEvent(event, emit),
        final AddEvent event => _addEvent(event, emit),
        final UpdateEvent event => _updateEvent(event, emit),
        final DeleteEvent event => _deleteEvent(event, emit),
        final ClearFilter event => _clearFilter(event, emit),
      },
    );
  }

  final EventRepository repository;

  List<EventModel> _allEvents = [];

  DateTime? _selectedDate;

  Future<void> _loadEvent(GetEvent event, Emitter<EventBlocState> emit) async {
    emit(state.copyWith(status: Status.loading));
    _allEvents = await repository.getEvents();

    final today = DateTime.now();
    _selectedDate = DateTime(today.year, today.month, today.day);

    emit(state.copyWith(status: Status.success, events: _eventsByDate(_selectedDate!), allEvents: _allEvents));
  }

  void _filterByDateEvent(FilterByDate event, Emitter<EventBlocState> emit) {
    _selectedDate = DateTime(event.date.year, event.date.month, event.date.day);

    emit(state.copyWith(status: Status.success, events: _eventsByDate(_selectedDate!)));
  }

  Future<void> _addEvent(AddEvent event, Emitter<EventBlocState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await repository.addEvent(event.event);

    _allEvents = await repository.getEvents();

    emit(
      state.copyWith(
        status: Status.success,
        events: _selectedDate == null ? <EventModel>[] : _eventsByDate(_selectedDate!),
        allEvents: _allEvents,
      ),
    );
  }

  Future<void> _updateEvent(UpdateEvent event, Emitter<EventBlocState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await repository.updateEvent(event.event);

    final index = _allEvents.indexWhere((e) => e.id == event.event.id);
    if (index != -1) {
      _allEvents[index] = event.event;
    }

    emit(
      state.copyWith(
        status: Status.success,
        events: _selectedDate == null ? <EventModel>[] : _eventsByDate(_selectedDate!),
        allEvents: List<EventModel>.from(_allEvents),
      ),
    );
  }

  Future<void> _deleteEvent(DeleteEvent event, Emitter<EventBlocState> emit) async {
    await repository.deleteEvent(event.id);

    _allEvents.removeWhere((e) => e.id == event.id);

    emit(
      state.copyWith(
        status: Status.success,
        events: _selectedDate == null ? <EventModel>[] : _eventsByDate(_selectedDate!),
        allEvents: List<EventModel>.from(_allEvents),
      ),
    );
  }

  void _clearFilter(ClearFilter event, Emitter<EventBlocState> emit) {
    _selectedDate = null;

    emit(state.copyWith(status: Status.success, events: <EventModel>[]));
  }

  List<EventModel> _eventsByDate(DateTime date) => _allEvents
      .where((e) => e.startTime.year == date.year && e.startTime.month == date.month && e.startTime.day == date.day)
      .toList();
}
