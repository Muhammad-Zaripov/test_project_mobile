part of 'event_bloc.dart';

class EventBlocState extends Equatable {
  const EventBlocState({this.status = .initial, this.events = const [], this.allEvents = const [], this.detailResult});

  final Status status;
  //tanlangan kundagi eventlar
  final List<EventModel> events;
  //barcha eventlar
  final List<EventModel> allEvents;

  final DetailResult? detailResult;

  EventBlocState copyWith({
    Status? status,
    List<EventModel>? events,
    List<EventModel>? allEvents,
    DetailResult? detailResult,
  }) => EventBlocState(
    status: status ?? this.status,
    events: events ?? this.events,
    allEvents: allEvents ?? this.allEvents,
    detailResult: detailResult ?? this.detailResult,
  );

  @override
  List<Object?> get props => [status, events, detailResult];
}
