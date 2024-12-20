part of 'weather_bloc.dart';

@immutable
sealed class WeatherBlocState extends Equatable {
  const WeatherBlocState();

  @override
  List<Object> get pros => [];
}

final class WeatherBlocInitial extends WeatherBlocState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class WeatherBlocLoading extends WeatherBlocState {
  final String name;
  const WeatherBlocLoading({required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [name];

}

final class WeatherBlocFailure extends WeatherBlocState {
  // final DateTime timestamp;
  final String str;
  const WeatherBlocFailure(this.str);
  // WeatherBlocFailure() : timestamp = DateTime.now();
  @override
  // TODO: implement props
  List<Object?> get props => [str];
}



final class WeatherBlocSucess extends WeatherBlocState {
  final Weather weather;
  const WeatherBlocSucess(this.weather);

  @override
  // TODO: implement props
  List<Object?> get props => [weather];


}



