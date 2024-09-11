part of 'current_location_cubit.dart';

@immutable
sealed class CurrentLocationState {}

final class CurrentLocationInitial extends CurrentLocationState {}

final class CurrentLocationLoading extends CurrentLocationState {}

final class CurrentLocationLoaded extends CurrentLocationState {

}

final class CurrentLocationError extends CurrentLocationState {}
