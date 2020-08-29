part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded(this.weather);

  @override
  List<Object> get props => [weather];
}

class WeatherLoadError extends WeatherState {
  final String message;

  const WeatherLoadError(this.message);

  @override
  List<Object> get props => [message];
}
