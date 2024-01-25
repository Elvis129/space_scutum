import 'package:flutter/material.dart';
import 'package:test_task_space_scutum_2/weather/models/weather_forecast_daily.dart';

class TempView extends StatelessWidget {
  final int index;
  final AsyncSnapshot<WeatherForecast> snapshot;
  const TempView({super.key, required this.index, required this.snapshot});
  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var icon = forecastList?[index].getIconUrl();
    var tempMin = forecastList?[index].temp?.min?.toStringAsFixed(0);
    var tempMax = forecastList?[index].temp?.max?.toStringAsFixed(0);
    var tempFeelsLike = forecastList?[index].feelsLike?.day?.toStringAsFixed(0);

    var description =
        forecastList?[index].weather?[0].description?.toUpperCase();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          icon!,
          scale: 0.4,
        ),
        const SizedBox(width: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text(
                  'min',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                Text(
                  '$tempMin °C',
                  style: const TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'feels like',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                Text(
                  '$tempFeelsLike °C',
                  style: const TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'max',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                Text(
                  '$tempMax °C',
                  style: const TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          '$description',
          style: const TextStyle(
            fontSize: 22.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
