part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}
final class UserProfileLoading extends UserProfileState {}
final class UserProfileLoaded extends UserProfileState {
  
}
final class UserProfileError extends UserProfileState {}
