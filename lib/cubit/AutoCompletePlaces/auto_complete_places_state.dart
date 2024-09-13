part of 'auto_complete_places_cubit.dart';

@immutable
sealed class AutoCompletePlacesState {}

final class AutoCompletePlacesInitial extends AutoCompletePlacesState {}

final class AutoCompletePlacesLoading extends AutoCompletePlacesState {}

final class AutoCompletePlacesLoaded extends AutoCompletePlacesState {
  final AutoCompletePlaces autoCompletePlaces;
  AutoCompletePlacesLoaded(this.autoCompletePlaces);
}

final class AutoCompletePlacesError extends AutoCompletePlacesState {}
