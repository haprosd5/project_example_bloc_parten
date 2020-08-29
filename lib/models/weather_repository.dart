import 'dart:math';

import 'package:dio/dio.dart';
import 'package:projec_weather_reso_coder/models/weather.dart';

final link_city = (String city) => 'https://www.metaweather.com/api/location/search/?query=$city';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);

  Future<Weather> fetchDetailedWeather(String cityName);

  Future<int> fetchFindIdCity(String city);
}

class FakeWeatherRepository implements WeatherRepository {
  double cachedTempCelsius;

  @override
  Future<Weather> fetchWeather(String cityName) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        // Simulate some network error
        if (random.nextBool()) {
          throw NetworkError();
        }

        // Since we're inside a fake repository, we need to cache the temperature
        // in order to have the same one returned in for the detailed weather
        cachedTempCelsius = 20 + random.nextInt(15) + random.nextDouble();

        // Return "fetched" weather
        return Weather(
          cityName: cityName,
          // Temperature between 20 and 35.99
          temperatureCelsius: cachedTempCelsius,
        );
      },
    );
  }

  @override
  Future<Weather> fetchDetailedWeather(String cityName) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return Weather(
          cityName: cityName,
          temperatureCelsius: cachedTempCelsius,
          temperatureFahrenheit: cachedTempCelsius * 1.8 + 32,
        );
      },
    );
  }

  @override
  // ignore: missing_return
  Future<int> fetchFindIdCity(String city) async {
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.get(link_city(city));

      if (response.statusCode == 200) {
        final result = response.data[0];
        return result['woeid'];
      } else
        return 0;
    } catch (e) {
      throw Exception('Loi roi');
    }
  }
}

class NetworkError extends Error {}
