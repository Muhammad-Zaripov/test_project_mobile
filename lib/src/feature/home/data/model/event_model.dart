import 'package:flutter/material.dart';
import '../enums/event_status.dart';

class EventModel {
  EventModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.location,
    required this.status,
    required this.color,
    required this.startTime,
    required this.endTime,
    this.id,
  });
  final int? id;
  final String title;
  final String subtitle;
  final String description;
  final String location;
  final EventStatus status;
  final Color color;
  final DateTime startTime;
  final DateTime endTime;
}
