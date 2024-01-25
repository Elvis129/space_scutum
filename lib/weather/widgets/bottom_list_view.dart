import 'package:flutter/material.dart';
import 'package:test_task_space_scutum_2/weather/models/weather_forecast_daily.dart';
import 'package:test_task_space_scutum_2/weather/screens/weather_day_forecast_screen.dart';
import 'package:test_task_space_scutum_2/weather/utilities/constants.dart';
import 'package:test_task_space_scutum_2/weather/widgets/forecast_card.dart';

class BottomListView extends StatefulWidget {
  final Future<WeatherForecast> forecastObject;
  final AsyncSnapshot<WeatherForecast> snapshot;

  const BottomListView({
    super.key,
    required this.forecastObject,
    required this.snapshot,
  });

  @override
  State<BottomListView> createState() => _BottomListViewState();
}

class _BottomListViewState extends State<BottomListView> {
  late WeatherForecast forecastData;
  late int index;

  @override
  void initState() {
    super.initState();
    widget.forecastObject.then((data) {
      setState(() {
        forecastData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Погода на 7 днів'.toUpperCase(),
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 140,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
              width: 8,
            ),
            itemCount: widget.snapshot.data!.list!.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                widget.forecastObject.then((data) {
                  setState(() {
                    forecastData = data;
                  });
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => WeatherDayForecastScreen(
                      forecastObject: forecastData,
                      index: index,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ConstantsColorWeather.colorAppBarWeather),
                width: MediaQuery.of(context).size.width / 2.7,
                height: 160,
                child: forecastCard(widget.snapshot, index),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
