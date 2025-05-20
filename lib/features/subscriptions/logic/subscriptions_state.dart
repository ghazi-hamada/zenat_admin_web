part of 'subscriptions_cubit.dart';

@immutable
abstract class SubscriptionsState {}

class SubscriptionsInitial extends SubscriptionsState {}

class SubscriptionsLoading extends SubscriptionsState {}

class SubscriptionsLoaded extends SubscriptionsState {
  final List<SubscriptionStatusModel> subscriptions;
  SubscriptionsLoaded(this.subscriptions);
}

class SubscriptionsError extends SubscriptionsState {
  final String error;
  SubscriptionsError(this.error);
}

class SubscriptionsShowSnackbar extends SubscriptionsState {
  final String message;
  final bool isError;
  SubscriptionsShowSnackbar({required this.message, this.isError = false});
}
