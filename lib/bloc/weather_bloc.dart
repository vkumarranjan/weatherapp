import 'dart:html';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBloc() : super(WeatherBlocInitial()) {
    on<FetchWeatherEvent>((event, emit) async {
      // TODO: implement event handler

      emit(const WeatherBlocLoading(name: 'loading'));
      await Future.delayed(const Duration(microseconds:  1000));

      try{

        emit(const WeatherBlocFailure('error1'));
        await Future.delayed(const Duration(microseconds: 3000));
        emit(const WeatherBlocFailure('error2'));

        WeatherFactory wf = WeatherFactory('c7c2d8a9f4c13a9d98ab7f31e12bdc0c', language: Language.ENGLISH);
        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude,
            event.position.longitude
        );
        print(weather);
        emit(WeatherBlocSucess(weather));
      } catch(e) {
        emit(const WeatherBlocFailure('error'));
      }
    });
  }
}


