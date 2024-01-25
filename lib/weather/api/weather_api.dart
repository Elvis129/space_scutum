import 'dart:convert';
import 'dart:developer';

import 'package:test_task_space_scutum_2/weather/models/weather_forecast_daily.dart';
import 'package:test_task_space_scutum_2/weather/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:test_task_space_scutum_2/weather/utilities/location.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecast(
      {String? cityName, bool? isCity}) async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, String?> parameters;

    if (isCity == true) {
      var queryParameters = {
        'appid': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'q': cityName,
      };
      parameters = queryParameters;
    } else {
      var queryParameters = {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'units': 'metric',
        'appid': Constants.WEATHER_APP_ID,
      };
      parameters = queryParameters;
    }

    var uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN,
        Constants.WEATHER_FORECAST_PATH, parameters);

    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    print('response: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      return Future.error('Error response');
    }
  }
}
