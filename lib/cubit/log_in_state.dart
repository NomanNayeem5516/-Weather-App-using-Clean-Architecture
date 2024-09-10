part of 'log_in_cubit.dart';

@immutable
sealed class LogInState {}

final class LogInInitial extends LogInState {}

final class LogInLoading extends LogInState {}

final class LogInLoaded extends LogInState {
  final LogInModel logInModel;
  LogInLoaded(this.logInModel);
}

final class LogInError extends LogInState {}
