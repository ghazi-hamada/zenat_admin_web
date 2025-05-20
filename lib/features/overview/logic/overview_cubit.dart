import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zenat_admin_web/core/class/crud.dart';
import 'package:zenat_admin_web/core/class/post_data.dart';
import 'package:zenat_admin_web/core/static/app_api_string.dart';
import 'package:zenat_admin_web/features/overview/data/SubscriptionStatusModel.dart';
import 'package:zenat_admin_web/features/overview/data/chart_model.dart';
import 'package:zenat_admin_web/features/overview/data/overview_model.dart';

part 'overview_state.dart';

class OverviewCubit extends Cubit<OverviewState> {
  OverviewCubit() : super(OverviewInitial());
  PostData postData = PostData(Crud());
  int totalUsers = 0;
  int totalFavorites = 0;
  int totalPayments = 0;
  int totalComplaints = 0;
  int totalBlocked = 0;
  String selectedPeriod = 'weekly';
  OverviewModel? overviewData;
  List<ChartData> chartData = [];
  List<SubscriptionStatusModel> subscriptionData = [];
  void setSelectedPeriod(String period) {
    selectedPeriod = period;
    emit(OverviewSuccess());
  }

  void getOverviewData() async {
    emit(OverviewLoading());
    try {
      Either<String, dynamic> response = await postData.postData(
        linkurl: AppApiString.OVERVIEW,
        data: {},
      );
      response.fold((l) => emit(OverviewFailure(l)), (r) {
        overviewData = OverviewModel.fromJson(r.cast<String, dynamic>());
        emit(OverviewSuccess());
      });
    } catch (e) {
      emit(OverviewFailure('خطأ غير متوقع'));
    }
  }

  Future<void> getDataToChart({String period = 'weekly'}) async {
    emit(OverviewChartLoading());
    try {
      Either<String, dynamic> response = await postData.postData(
        linkurl: AppApiString.CHART,
        data: {'period': period},
      );

      response.fold((l) => emit(OverviewFailure(l)), (r) {
        if (r['status'] == 'success') {
          chartData =
              (r['data'] as List).map((e) => ChartData.fromJson(e)).toList();
          emit(OverviewSuccess());
        } else {
          emit(OverviewFailure('فشل تحميل البيانات'));
        }
      });
    } catch (e) {
      emit(OverviewFailure('خطاء غير متوقع'));
    }
  }

  Future<void> getDataToPieChart() async {
    emit(OverviewLoading());
    try {
      Either<String, dynamic> response = await postData.postData(
        linkurl: AppApiString.PIE_CHART,
        data: {},
      );

      response.fold((l) => emit(OverviewFailure(l)), (r) {
        final List<dynamic> jsonList = r['data'];
        subscriptionData =
            jsonList.map((e) => SubscriptionStatusModel.fromJson(e)).toList();
        emit(OverviewSuccess());
      });
    } catch (e) {
      emit(OverviewFailure('خطاء غير متوقع'));
    }
  }
}
