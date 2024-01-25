import 'package:flutter/material.dart';
import 'package:test_task_space_scutum_2/weather/api/weather_api.dart';
import 'package:test_task_space_scutum_2/weather/screens/weather_forecast_screen.dart';

class WeatherButton extends StatelessWidget {
  const WeatherButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      icon: const Icon(Icons.cloud),
      onPressed: () async {
        var weatherInfo = await WeatherApi().fetchWeatherForecast();

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return WeatherForecastScreen(
                locationWeather: weatherInfo,
              );
            },
          ),
        );
      },
    );
  }
}
