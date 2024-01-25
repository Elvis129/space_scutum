import 'package:flutter/material.dart';
import 'package:test_task_space_scutum_2/weather/models/weather_forecast_daily.dart';
import 'package:test_task_space_scutum_2/weather/utilities/forecast_util.dart';

class CityView extends StatelessWidget {
  final int index;
  final AsyncSnapshot<WeatherForecast> snapshot;
  const CityView({super.key, required this.index, required this.snapshot});
  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var city = snapshot.data?.city?.name;
    var country = snapshot.data?.city?.country;
    var formattedDate =
        DateTime.fromMicrosecondsSinceEpoch(forecastList![index].dt! * 1000000);
    return Column(
      children: [
        Text(
          '$city, $country',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28.0, color: Colors.white),
        ),
        Text(
          Util.getFormattedDate(formattedDate),
          style: const TextStyle(fontSize: 15.0, color: Colors.white),
        )
      ],
    );
  }
}
