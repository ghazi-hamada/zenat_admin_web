import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:zenat_admin_web/core/class/crud.dart';
import 'package:zenat_admin_web/core/class/post_data.dart';
import 'package:zenat_admin_web/core/helper/constants.dart';
import 'package:zenat_admin_web/core/helper/shared_pref_helper.dart';
import 'package:zenat_admin_web/core/static/app_api_string.dart';
import 'package:zenat_admin_web/features/settings/data/UsersDataModel.dart';

// تعديل دور المستخدم
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  PostData postData = PostData(Crud());
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final birthDateCtrl = TextEditingController();
  final oldPasswordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  bool isPasswordVisible = true;
  bool isOldPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  void togglePasswordVisibility() {
    emit(SettingsLoading());
    isPasswordVisible = !isPasswordVisible;
    emit(SettingsInitial());
  }

  void toggleOldPasswordVisibility() {
    emit(SettingsLoading());
    isOldPasswordVisible = !isOldPasswordVisible;
    emit(SettingsInitial());
  }

  void toggleConfirmPasswordVisibility() {
    emit(SettingsLoading());
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(SettingsInitial());
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UsersDataModel myProfileModel = UsersDataModel();
  void setControllers() async {
    String userPhone = await SharedPrefHelper.getString(
      SharedPrefKeys.userPhone,
    );

    nameCtrl.text = await SharedPrefHelper.getString(SharedPrefKeys.userName);
    emailCtrl.text = await SharedPrefHelper.getString(SharedPrefKeys.userEmail);
    phoneCtrl.text = userPhone;
    birthDateCtrl.text = await SharedPrefHelper.getString(
      SharedPrefKeys.userBirthDate,
    );
  }

  void init() {
    setControllers();
    getMyProfile();
  }

  void getMyProfile() async {
    emit(SettingsLoading());
    int userId = await SharedPrefHelper.getInt(SharedPrefKeys.userId);
    var response = await postData.postData(
      linkurl: AppApiString.GET_MY_PROFILE,
      data: {'userId': userId.toString()},
    );
    response.fold((l) => emit(SettingsFailure(l)), (r) async {
      if (r['status'] == 'success') {
        // Ensure the response data is a Map
        final data = r['data'] is List ? r['data'].first : r['data'];
        myProfileModel = UsersDataModel.fromJson(data);
        nameCtrl.text = myProfileModel.usersName ?? '';
        emailCtrl.text = myProfileModel.usersEmail ?? '';
        phoneCtrl.text = myProfileModel.usersPhone?.toString() ?? '';
        birthDateCtrl.text = myProfileModel.usersBirthDate ?? '';
        await SharedPrefHelper.setData(
          SharedPrefKeys.userName,
          myProfileModel.usersName ?? '',
        );
        await SharedPrefHelper.setData(
          SharedPrefKeys.userEmail,
          myProfileModel.usersEmail ?? '',
        );
        await SharedPrefHelper.setData(
          SharedPrefKeys.userPhone,
          myProfileModel.usersPhone?.toString() ?? '',
        );
        await SharedPrefHelper.setData(
          SharedPrefKeys.userBirthDate,
          myProfileModel.usersBirthDate ?? '',
        );
        await SharedPrefHelper.setData(
          SharedPrefKeys.userImage,
          myProfileModel.usersImegUrl ?? '',
        );
        emit(SettingsSuccess());
      } else {
        emit(SettingsFailure(r['message']));
      }
    });
    emit(SettingsSuccess());
  }

  void editProfile() async {
    emit(SettingsLoading());
    try {
      int userId = await SharedPrefHelper.getInt(SharedPrefKeys.userId);
      final Map<String, String> data = {
        'userId': userId.toString(),
        'username': nameCtrl.text,
        'userEmail': emailCtrl.text,
        'userPhone': phoneCtrl.text,
        'userBirthDate': birthDateCtrl.text,
      };
      final response = await http.post(
        Uri.parse(AppApiString.EDIT_PROFILE),
        body: data,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer s9TkN2vBq7XjL4gPfWdR6mZoCvYeHtKm',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          emit(SettingsShowSnackbar(message: 'تم تعديل البيانات بنجاح'));
          getMyProfile();
        } else {
          emit(SettingsFailure(responseData['message'] ?? 'خطاء غير متوقع'));
        }
      } else {
        emit(
          SettingsShowSnackbar(
            message: 'فشل الاتصال بالخادم: ${response.statusCode}',
            isError: true,
          ),
        );
      }
    } catch (e) {
      emit(SettingsFailure('خطأ غير متوقع'));
    }
  }

  void changePassword() async {
    if (!formKey.currentState!.validate()) {
      // إذا لم يتم التحقق من صحة النموذج، لا تكمل العملية
      emit(
        SettingsShowSnackbar(
          message: 'يرجى ملء جميع الحقول بشكل صحيح',
          isError: true,
        ),
      );
      return;
    }
    emit(SettingsLoading());
    try {
      int userId = await SharedPrefHelper.getInt(SharedPrefKeys.userId);
      var response = await postData.postData(
        linkurl: AppApiString.CHANGE_PASSWORD,
        data: {
          'userid': userId.toString(),
          'oldpassword': oldPasswordCtrl.text,
          'newpassword': passwordCtrl.text,
        },
      );
      response.fold((l) => emit(SettingsFailure(l)), (r) {
        if (r['status'] == 'success') {
          emit(SettingsShowSnackbar(message: 'تم تغيير كلمة المرور بنجاح'));
          emit(SettingsSuccess());
        } else {
          emit(SettingsFailure(r['message']));
        }
      });
    } catch (e) {
      emit(SettingsFailure('خطأ غير متوقع'));
    }
  }

  void cleanPassword() {
    emit(SettingsLoading());
    passwordCtrl.clear();
    oldPasswordCtrl.clear();
    confirmPasswordCtrl.clear();
    isPasswordVisible = true;
    isOldPasswordVisible = true;
    isConfirmPasswordVisible = true;
    emit(SettingsInitial());
  }
}
