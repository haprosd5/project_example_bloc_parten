import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projec_weather_reso_coder/blocs/weather/weather_bloc.dart';
import 'package:projec_weather_reso_coder/models/weather.dart';

class WeatherDetailPage extends StatelessWidget {
  final Weather masterWeather;

  const WeatherDetailPage({
    Key key,
    @required this.masterWeather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context)..add(GetDetailWeather(masterWeather.cityName));

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Detail"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        //TODO: Display the weather detail using Bloc
        child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherLoading) {
            return buildLoading();
          } else if (state is WeatherLoaded) {
            // ignore: missing_return
            return buildColumnWithData(context, state.weather);
          } else {
            return buildLoading();
          }
        }),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the Celsius temperature with 1 decimal place
          "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        Text(
          // Display the Fahrenheit temperature with 1 decimal place
          "${weather.temperatureFahrenheit?.toStringAsFixed(1)} °F",
          style: TextStyle(fontSize: 80),
        ),
      ],
    );
  }
}
