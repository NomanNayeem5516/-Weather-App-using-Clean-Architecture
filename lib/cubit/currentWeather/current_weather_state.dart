part of 'current_weather_cubit.dart';

@immutable
sealed class CurrentWeatherState {}

final class CurrentWeatherInitial extends CurrentWeatherState {}
final class CurrentWeatherLoading extends CurrentWeatherState {}
final class CurrentWeatherLoaded extends CurrentWeatherState {
  final CurrentWeatherModel currentWeatherModel;
  final String address;
  CurrentWeatherLoaded(this.currentWeatherModel, this.address);
}
final class CurrentWeatherError extends CurrentWeatherState {}
