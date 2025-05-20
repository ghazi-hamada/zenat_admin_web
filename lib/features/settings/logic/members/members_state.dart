part of 'members_cubit.dart';

@immutable
abstract class MembersState {}

class MembersInitial extends MembersState {}

class MembersLoaded extends MembersState {}

class MembersLoading extends MembersState {}

class MembersFailure extends MembersState {
  final String error;
  MembersFailure(this.error);
}

class MembersSuccess extends MembersState {}

class MembersShowSnackbar extends MembersState {
  final String message;
  final bool isError;
  MembersShowSnackbar({this.isError = false, required this.message});
}
