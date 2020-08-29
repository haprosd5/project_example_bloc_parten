import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projec_weather_reso_coder/models/weather.dart';
import 'package:projec_weather_reso_coder/models/weather_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoading();
    if (event is GetWeather) {
      try {
        final response = await repository.fetchWeather(event.cityName);
        yield WeatherLoaded(response);
      } on NetworkError {
        yield WeatherLoadError('Load thoi tiet bi loi');
      }
    } else if (event is GetDetailWeather) {
      try {
        final response = await repository.fetchDetailedWeather(event.cityName);
        yield WeatherLoaded(response);
      } on NetworkError {
        yield WeatherLoadError('Load thoi tiet bi loi');
      }
    }
  }
}
