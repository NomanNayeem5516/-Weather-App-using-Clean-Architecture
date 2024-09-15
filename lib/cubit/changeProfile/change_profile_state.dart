part of 'change_profile_cubit.dart';

@immutable
sealed class ChangeProfileState {}

final class ChangeProfileInitial extends ChangeProfileState {}

final class ChangeProfileLoading extends ChangeProfileState {}

final class ChangeProfileLoaded extends ChangeProfileState {
  final ChangeProfileModel changeProfileModel;
  ChangeProfileLoaded(this.changeProfileModel);
}

final class ChangeProfileError extends ChangeProfileState {}
