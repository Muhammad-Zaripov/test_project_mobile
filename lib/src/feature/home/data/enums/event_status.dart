import 'package:flutter/material.dart';

enum EventStatus {
  danger,
  warning,
  success;

  bool get isSuccess => this == .success;
  bool get isWarning => this == .warning;
  bool get isDanger => this == .danger;

  Color get color => switch (this) {
    .danger => Colors.red,
    .warning => Colors.orangeAccent,
    _ => Colors.blue,
  };
}
