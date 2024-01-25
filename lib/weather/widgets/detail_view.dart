import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_task_space_scutum_2/weather/models/weather_forecast_daily.dart';
import 'package:test_task_space_scutum_2/weather/utilities/forecast_util.dart';

class DatailView extends StatelessWidget {
  final int index;
  final AsyncSnapshot<WeatherForecast> snapshot;
  const DatailView({super.key, required this.index, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var pressure = forecastList![index].pressure! * 0.750062;
    var humidity = forecastList[index].humidity;
    var wind = forecastList[index].speed;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Util.getItem(FontAwesomeIcons.thermometer, pressure.round(), 'mm Hg'),
        Util.getItem(FontAwesomeIcons.cloudRain, humidity!, '%'),
        Util.getItem(FontAwesomeIcons.wind, wind!.toInt(), 'm/s')
      ],
    );
  }
}
