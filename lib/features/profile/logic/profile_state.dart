part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure(this.message);
}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserFullProfileModel userFullProfileModel;
  ProfileSuccess(this.userFullProfileModel);
}

 