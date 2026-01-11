import 'package:elixir/elixir.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feature/home/data/model/event_model.dart';
import '../../feature/home/presentation/blocs/event_bloc/event_bloc.dart';
import '../../feature/home/presentation/blocs/home_bloc/home_bloc.dart';
import '../../feature/home/presentation/screen/add_screen.dart';
import '../../feature/home/presentation/screen/details_screen.dart';
import '../../feature/home/presentation/screen/home_screen.dart';
import '../../feature/settings/screen/settings_screen.dart';
import 'custom_material_route.dart';

@immutable
sealed class AppPage extends ElixirPage {
  const AppPage({required super.name, required super.child, super.arguments, super.key});

  @override
  int get hashCode => key.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppPage && key == other.key;

  @override
  String toString() => '/$name${arguments.isEmpty ? '' : '~$arguments'}';
}

final class HomePage extends AppPage {
  HomePage({HomeState? state})
    : super(
        child: BlocProvider(
          create: (context) => HomeBloc(initialState: state),
          child: const HomeScreen(),
        ),
        name: 'home',
      );

  @override
  Set<String> get tags => {'home'};
}

final class AddPage extends AppPage {
  AddPage({required EventBloc eventBloc, required DateTime selectedDate, EventModel? event})
    : super(
        name: 'add',
        child: BlocProvider.value(
          value: eventBloc,
          child: AddScreen(selectedDate: selectedDate, event: event),
        ),
      );

  @override
  Set<String> get tags => throw UnimplementedError();
}

final class DetailPage extends AppPage {
  DetailPage({required EventBloc eventBloc, required int eventId})
    : super(
        name: 'detail',
        arguments: {'eventId': eventId},
        child: BlocProvider.value(
          value: eventBloc,
          child: DetailScreen(eventId: eventId),
        ),
      );

  @override
  Set<String> get tags => {'home'};
}

final class SettingsPage extends AppPage {
  SettingsPage({required final String data})
    : super(
        child: SettingsScreen(data: data),
        name: 'settings',
      );

  @override
  Route<void> createRoute(BuildContext context) => CustomMaterialRoute(page: this);

  @override
  Set<String> get tags => {'settings'};
}
