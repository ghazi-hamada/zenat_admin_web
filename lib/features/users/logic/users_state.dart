part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}
class UsersFailure extends UsersState {
  final String message;
  UsersFailure(this.message);
}
class UsersLoading extends UsersState {}
class UsersSuccess extends UsersState {
  final List<UsersModel> usersList;
  UsersSuccess(this.usersList);
}


class UsersBlockSuccess extends UsersState {}
