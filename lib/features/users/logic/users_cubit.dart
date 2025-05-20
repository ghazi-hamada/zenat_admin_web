import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zenat_admin_web/core/class/crud.dart';
import 'package:zenat_admin_web/core/class/post_data.dart';
import 'package:zenat_admin_web/core/helper/constants.dart';
import 'package:zenat_admin_web/core/helper/shared_pref_helper.dart';
import 'package:zenat_admin_web/core/static/app_api_string.dart';
import 'package:zenat_admin_web/features/users/data/UsersModel.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());
  PostData postData = PostData(Crud());
List<UsersModel> usersList = [];
  void getUsers() async {
    emit(UsersLoading());
    try {
      final response = await postData.postData(
        linkurl: AppApiString.USERS,
        data: {},
      );
      response.fold((l) => emit(UsersFailure(l)), (r) {
        usersList =
            (r['data'] as List).map((e) => UsersModel.fromJson(e)).toList();
        emit(UsersSuccess(usersList));
      });
    } catch (e) {
      emit(UsersFailure('خطأ غير متوقع'));
    }
  }

  // in UsersCubit

  void addBlockUser({
    required String userId,
    required String reason,
    required String expiresAt,
    required String isPermanent,
    required String notes,
  }) async {
    emit(UsersLoading());
    try {
      int blockedByAdmin = await SharedPrefHelper.getInt(SharedPrefKeys.userId);
      final response = await postData.postData(
        linkurl: AppApiString.ADD_BLOCK_USER,
        data: {
          'userid': userId,
          'blockedByAdmin': blockedByAdmin.toString(),
          'reason': reason,
          'expiresAt': expiresAt,
          'isPermanent': isPermanent,
          'notes': notes,
        },
      );
      response.fold((l) => emit(UsersFailure(l)), (r) {
        if (r['status'] == 'success') {
          emit(UsersBlockSuccess());
          // بعد البلوك نعيد جلب اللست
          getUsers();
        } else {
          emit(UsersFailure(r['message'] ?? 'فشل البلوك'));
        }
      });
    } catch (e) {
      emit(UsersFailure('حدث خطأ غير متوقع: $e'));
    }
  }
}
