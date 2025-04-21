import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_home_state.dart';

class DashboardHomeCubit extends Cubit<DashboardHomeState> {
  DashboardHomeCubit() : super(DashboardHomeInitial());
}
