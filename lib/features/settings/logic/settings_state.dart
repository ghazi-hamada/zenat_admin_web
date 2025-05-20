part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsSuccess extends SettingsState {}

class SettingsFailure extends SettingsState {
  final String error;
  SettingsFailure(this.error);
}

class SettingsShowSnackbar extends SettingsState {
  final String message;
  final bool isError;
  SettingsShowSnackbar({required this.message, this.isError = false});
}
