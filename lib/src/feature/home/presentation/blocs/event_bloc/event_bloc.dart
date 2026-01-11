import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/enum/bloc_status_enum.dart';
import '../../../data/enums/details_model.dart';
import '../../../data/model/event_model.dart';
import '../../../data/repository/home_repository.dart';

part 'event_state.dart';
part 'event_event.dart';

class EventBloc extends Bloc<EventBlocEvent, EventBlocState> {
  EventBloc(this.repository) : super(const EventBlocState()) {
    on<GetEvent>(_loadEvent);
    on<FilterByDate>(_filterByDateEvent);
    on<AddEvent>(_addEvent);
    on<UpdateEvent>(_updateEvent);
    on<DeleteEvent>(_deleteEvent);
  }
  final EventRepository repository;
  List<EventModel> _allEvents = [];
  final today = DateTime.now();

  Future<void> _loadEvent(GetEvent event, Emitter<EventBlocState> emit) async {
    emit(state.copyWith(status: .loading));

    _allEvents = await repository.getEvents();

    final todayEvents = _allEvents
        .where(
          (e) => e.startTime.year == today.year && e.startTime.month == today.month && e.startTime.day == today.day,
        )
        .toList();

    emit(state.copyWith(status: .success, events: todayEvents, allEvents: _allEvents));
  }

  void _filterByDateEvent(FilterByDate event, Emitter<EventBlocState> emit) {
    final filtered = _allEvents
        .where(
          (e) =>
              e.startTime.year == event.date.year &&
              e.startTime.month == event.date.month &&
              e.startTime.day == event.date.day,
        )
        .toList();

    emit(state.copyWith(status: .success, events: filtered));
  }

  Future<void> _addEvent(AddEvent event, Emitter<EventBlocState> emit) async {
    emit(state.copyWith(status: .loading));

    await repository.addEvent(event.event);

    _allEvents = await repository.getEvents();

    emit(state.copyWith(status: .success, events: _allEvents, allEvents: _allEvents));
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
        events: List<EventModel>.from(_allEvents),
        allEvents: List<EventModel>.from(_allEvents),
      ),
    );
  }

  Future<void> _deleteEvent(DeleteEvent event, Emitter<EventBlocState> emit) async {
    await repository.deleteEvent(event.id);

    _allEvents.removeWhere((e) => e.id == event.id);

    emit(
      state.copyWith(
        status: .success,
        events: List<EventModel>.from(_allEvents),
        allEvents: List<EventModel>.from(_allEvents),
      ),
    );
  }
}
