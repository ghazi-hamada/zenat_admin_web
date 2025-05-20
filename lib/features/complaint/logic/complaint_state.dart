part of 'complaint_cubit.dart';

@immutable
abstract class ComplaintState {}

class ComplaintInitial extends ComplaintState {}
class ComplaintLoading extends ComplaintState {}
class ComplaintLoaded extends ComplaintState {
  final List<ComplaintModel> complaints;
  ComplaintLoaded(this.complaints);
}
class ComplaintError extends ComplaintState {
  final String error;
  ComplaintError(this.error);
}
