import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zenat_admin_web/core/class/crud.dart';
import 'package:zenat_admin_web/core/class/post_data.dart';
import 'package:zenat_admin_web/core/static/app_api_string.dart';
import 'package:zenat_admin_web/features/profile/data/model/user_full_profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  PostData postData = PostData(Crud());
  UserFullProfileModel? userFullProfileModel;

  void getUserFullProfileData({required String userId}) async {
    emit(ProfileLoading());
    try {
      final response = await postData.postData(
        linkurl: AppApiString.USER_PROFILE,
        data: {
          'userid': userId, // تأكد إنه نفس اسم المعامل في الـ API
        },
      );

      response.fold((l) => emit(ProfileFailure(l)), (r) {
        // نتأكد أولًا من الحالة
        if (r['status'] == 'success' &&
            r['data'] is List &&
            (r['data'] as List).isNotEmpty) {
          final json = (r['data'] as List).first as Map<String, dynamic>;
          userFullProfileModel = UserFullProfileModel.fromJson(json);
          emit(ProfileSuccess(userFullProfileModel!));
        } else {
          emit(ProfileFailure('لم يتم العثور على بيانات المستخدم'));
        }
      });
    } catch (e) {
      emit(ProfileFailure('حدث خطأ غير متوقع $e'));
    }
  }



}
