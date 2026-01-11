import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import '../enums/event_status.dart';
import '../model/event_model.dart';

abstract class EventRepository {
  Future<List<EventModel>> getEvents();
  Future<void> addEvent(EventModel event);
  Future<void> updateEvent(EventModel event);
  Future<void> deleteEvent(int id);
}

class EventRepositoryImpl implements EventRepository {
  EventRepositoryImpl(this.db);

  final Database db;

  @override
  Future<List<EventModel>> getEvents() async {
    final rows = await db.select(db.events).get();

    return rows
        .map(
          (e) => EventModel(
            id: e.id,
            title: e.title,
            subtitle: e.subtitle,
            description: e.description,
            location: e.location,
            status: EventStatus.values.byName(e.status),
            color: Color(e.statusColor),
            startTime: e.startTime,
            endTime: e.endTime,
          ),
        )
        .toList();
  }

  @override
  Future<void> addEvent(EventModel event) async {
    await db
        .into(db.events)
        .insert(
          EventsCompanion.insert(
            title: event.title,
            subtitle: event.subtitle,
            description: event.description,
            location: event.location,
            status: event.status.name,
            statusColor: event.color.toARGB32(),
            startTime: event.startTime,
            endTime: event.endTime,
          ),
        );
  }

  @override
  Future<void> updateEvent(EventModel event) async {
    if (event.id == null) return;

    await (db.update(db.events)..where((tbl) => tbl.id.equals(event.id!))).write(
      EventsCompanion(
        title: Value(event.title),
        subtitle: Value(event.subtitle),
        description: Value(event.description),
        location: Value(event.location),
        status: Value(event.status.name),
        statusColor: Value(event.color.toARGB32()),
        startTime: Value(event.startTime),
        endTime: Value(event.endTime),
      ),
    );
  }

  @override
  Future<void> deleteEvent(int id) async {
    await (db.delete(db.events)..where((tbl) => tbl.id.equals(id))).go();
  }
}
