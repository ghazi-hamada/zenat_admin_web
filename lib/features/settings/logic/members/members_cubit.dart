import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenat_admin_web/core/class/crud.dart';
import 'package:zenat_admin_web/core/class/post_data.dart';
import 'package:zenat_admin_web/core/helper/constants.dart';
import 'package:zenat_admin_web/core/helper/shared_pref_helper.dart';
import 'package:zenat_admin_web/core/static/app_api_string.dart';
import 'package:zenat_admin_web/features/settings/data/UsersDataModel.dart';

part 'members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  MembersCubit() : super(MembersInitial());
  List<UsersDataModel> membersData = [];
  PostData postData = PostData(Crud());
  void getMembers() async {
    emit(MembersLoading());
    int userId = await SharedPrefHelper.getInt(SharedPrefKeys.userId);
    var response = await postData.postData(
      linkurl: AppApiString.GET_MEMBERS,
      data: {'userId': userId.toString()},
    );
    response.fold((l) => emit(MembersFailure(l)), (r) {
      if (r['status'] == 'success') {
        membersData =
            (r['data'] as List).map((e) => UsersDataModel.fromJson(e)).toList();
        emit(MembersSuccess());
      } else {
        emit(MembersFailure(r['message']));
      }
    });
  }

  void createNewAccountMember({
    required String name,
    required String email,
    required String phone,
    required String birthDate,
    required String gender, // 1 = ذكر, 0 = أنثى
    required String password,
    required String usersType, // 1 = Admin, 2 = Read Only
  }) async {
    emit(MembersLoading());
    try {
      int userId = await SharedPrefHelper.getInt(SharedPrefKeys.userId);
      var response = await postData.postData(
        linkurl: AppApiString.CREATE_NEW_ACCOUNT,
        data: {
          'username': name,
          'email': email,
          'password': password,
          'barthday': birthDate,
          'gender': gender,
          'phone': phone,
          'usersType': usersType,
        },
      );
      response.fold(
        (l) {
          emit(
            MembersShowSnackbar(
              message: 'الايميل او رقم الهاتف مستخدم مسبقا',
              isError: true,
            ),
          );
        },
        (r) {
          if (r['status'] == 'success') {
            emit(MembersShowSnackbar(message: 'تم إنشاء الحساب بنجاح'));
            getMembers();
          } else {
            emit(MembersFailure(r['message']));
          }
        },
      );
    } catch (e) {
      emit(MembersFailure('خطأ غير متوقع'));
    } finally {
      emit(MembersSuccess());
    }
  }

  Future<void> editRole({required int userId, required String newRole}) async {
    emit(MembersLoading());
    try {
      final Map<String, String> data = {
        'userid': userId.toString(),
        'usersType': newRole,
      };

      final response = await http.post(
        Uri.parse(AppApiString.EDIT_ACCOUNT),
        body: data,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer s9TkN2vBq7XjL4gPfWdR6mZoCvYeHtKm',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          emit(MembersShowSnackbar(message: 'تم تعديل صلاحية العضو بنجاح'));
          getMembers();
        } else {
          emit(MembersFailure(responseData['message'] ?? 'خطأ غير متوقع'));
        }
      } else {
        emit(MembersFailure('فشل الاتصال بالخادم: ${response.statusCode}'));
      }
    } catch (e) {
      emit(MembersFailure('خطأ غير متوقع'));
    } finally {
      emit(MembersSuccess());
    }
  }

  Future<void> removeAccountMember({required int userId}) async {
    emit(MembersLoading());
    try {
      final Map<String, String> data = {
        'userid': userId.toString(),
        'usersType': '0',
      };

      final response = await http.post(
        Uri.parse(AppApiString.EDIT_ACCOUNT),
        body: data,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer s9TkN2vBq7XjL4gPfWdR6mZoCvYeHtKm',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          emit(MembersShowSnackbar(message: 'تم حذف العضو بنجاح'));
          getMembers();
        } else {
          emit(MembersFailure(responseData['message'] ?? 'خطأ غير متوقع'));
        }
      } else {
        emit(MembersFailure('فشل الاتصال بالخادم: ${response.statusCode}'));
      }
    } catch (e) {
      emit(MembersFailure('خطأ غير متوقع'));
    } finally {
      emit(MembersSuccess());
    }
  }
}
