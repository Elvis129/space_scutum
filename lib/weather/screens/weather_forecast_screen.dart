import 'package:flutter/material.dart';
import 'package:test_task_space_scutum_2/weather/api/weather_api.dart';
import 'package:test_task_space_scutum_2/weather/models/weather_forecast_daily.dart';
import 'package:test_task_space_scutum_2/weather/screens/city_screen.dart';
import 'package:test_task_space_scutum_2/weather/utilities/constants.dart';
import 'package:test_task_space_scutum_2/weather/widgets/bottom_list_view.dart';
import 'package:test_task_space_scutum_2/weather/widgets/city_view.dart';
import 'package:test_task_space_scutum_2/weather/widgets/detail_view.dart';
import 'package:test_task_space_scutum_2/weather/widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  final int index = 0;
  final WeatherForecast? locationWeather;
  const WeatherForecastScreen({Key? key, this.locationWeather})
      : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;

  late String _cityName;

  @override
  void initState() {
    super.initState();
    if (widget.locationWeather != null) {
      forecastObject = Future.value(widget.locationWeather);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantsColorWeather.colorAppBarWeather,
        title: const Text('Погода'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              setState(() {
                forecastObject = WeatherApi().fetchWeatherForecast();
              });
            },
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () async {
                var tappedName = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return const CityScreen();
                }));
                if (tappedName != null) {
                  setState(() {
                    _cityName = tappedName;
                    forecastObject = WeatherApi().fetchWeatherForecast(
                        cityName: _cityName, isCity: true);
                  });
                }
              },
              icon: const Icon(Icons.location_city))
        ],
      ),
      body: Container(
        color: ConstantsColorWeather.colorBodyWeather,
        child: ListView(
          children: [
            FutureBuilder<WeatherForecast>(
              future: forecastObject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50.0,
                      ),
                      CityView(
                        snapshot: snapshot,
                        index: widget.index,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TempView(
                        snapshot: snapshot,
                        index: widget.index,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      DatailView(
                        snapshot: snapshot,
                        index: widget.index,
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      BottomListView(
                        snapshot: snapshot,
                        forecastObject: forecastObject,
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 250,
                        ),
                        Text(
                          'City not found\nPlease, enter correct city',
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
