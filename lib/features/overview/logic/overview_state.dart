part of 'overview_cubit.dart';

@immutable
abstract class OverviewState {}

class OverviewInitial extends OverviewState {}

class OverviewFailure extends OverviewState {
  final String message;
  OverviewFailure(this.message);
}
class OverviewLoading extends OverviewState {}
class OverviewChartLoading extends OverviewState {} // <-- أضف هذا

class OverviewSuccess extends OverviewState {
  OverviewSuccess( );
}


