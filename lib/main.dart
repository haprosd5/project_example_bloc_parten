import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projec_weather_reso_coder/blocs/weather/weather_bloc.dart';
import 'package:projec_weather_reso_coder/models/weather_repository.dart';
import 'package:projec_weather_reso_coder/pages/search_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => WeatherBloc(FakeWeatherRepository()),
        child: WeatherSearchPage(),
      ),
    );
  }
}