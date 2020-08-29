import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projec_weather_reso_coder/blocs/weather/weather_bloc.dart';
import 'package:projec_weather_reso_coder/models/weather.dart';
import 'package:projec_weather_reso_coder/models/weather_repository.dart';
import 'package:projec_weather_reso_coder/pages/search_detail_page.dart';

class WeatherSearchPage extends StatelessWidget {
  final fake = FakeWeatherRepository();
  @override
  Widget build(BuildContext context) {
    fake.fetchFindIdCity('london');
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        //TODO: Display the weather and loading indicator using Bloc
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoadError) {
              // ignore: missing_return
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
            /*Thiết lập các trạng thái của ứng dụng*/
            if (state is WeatherInitial) {
              return buildInitialInput();
            } else if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              // ignore: missing_return
              return buildColumnWithData(context, state.weather);
            } else {
              return buildInitialInput();
            }
          }),
        ),
      ),
    );
  }

  // khởi tạo
  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildError() {
    return Center(
      child: Text('Loi roi'),
    );
  }

  // loading
  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // hiển thị thời tiết
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
          // Display the temperature with 1 decimal place
          "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        RaisedButton(
          child: Text('See Details'),
          color: Colors.lightBlue[100],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<WeatherBloc>(context),
                  child: WeatherDetailPage(
                    masterWeather: weather,
                  ),
                ),
              ),
            );
          },
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

void submitCityName(BuildContext context, String cityName) {
  final driver = BlocProvider.of<WeatherBloc>(context);
  driver.add(GetWeather(cityName));
}

/*
* BlocProvider.value(
                  value: BlocProvider.of<WeatherBloc>(context),
                  child: WeatherDetailPage(
                    masterWeather: weather,
                  ),
                ),
                * */
