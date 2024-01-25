import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_space_scutum_2/note/note_bloc/note_bloc.dart';
import 'package:test_task_space_scutum_2/note/pages/note_app.dart';
import 'package:test_task_space_scutum_2/weather/screens/location_screen.dart';
import 'package:test_task_space_scutum_2/weather/screens/weather_day_forecast_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home_note',
      routes: {
        '/home_note': (context) => BlocProvider(
              create: (context) => NoteBloc(),
              child: const MyNoteApp(),
            ),
        '/weather': (context) => const LocationScreen(),
        '/weather_day': (context) => const WeatherDayForecastScreen(
              forecastObject: null,
              index: 0,
            ),
      },
    );
  }
}
