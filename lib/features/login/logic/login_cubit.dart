import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zenat_admin_web/core/class/crud.dart';
import 'package:zenat_admin_web/core/class/post_data.dart';
import 'package:zenat_admin_web/core/helper/constants.dart';
import 'package:zenat_admin_web/core/helper/shared_pref_helper.dart';
import 'package:zenat_admin_web/core/static/app_api_string.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;

  void togglePasswordVisibility() {
    emit(LoginLoading());
    isPasswordVisible = !isPasswordVisible;
    emit(LoginInitial());
  }

  PostData postData = PostData(Crud());

  void login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());
      try {
        Either<String, dynamic> response = await postData
            .postData(
              linkurl: AppApiString.LOGIN,
              data: {
                "email": usernameController.text.toString(),
                "password": passwordController.text.toString(),
              },
            );
        print(response);
        response.fold(
          (l) {
            emit(LoginFailure(l));
          },
          (r) async {
            await SharedPrefHelper.setData(SharedPrefKeys.isLogin, 'true');
            await SharedPrefHelper.setData(
              SharedPrefKeys.userId,
              r['data']['users_id'],
            );
            await SharedPrefHelper.setData(
              SharedPrefKeys.userName,
              r['data']['users_name'].toString(),
            );
            await SharedPrefHelper.setData(
              SharedPrefKeys.userEmail,
              r['data']['users_email'].toString(),
            );
            await SharedPrefHelper.setData(
              SharedPrefKeys.userImage,
              r['data']['users_image'].toString(),
            );
            await SharedPrefHelper.setData(
              SharedPrefKeys.userPhone,
              r['data']['users_phone'].toString(),
            );
            await SharedPrefHelper.setData(
              SharedPrefKeys.userBirthDate,
              r['data']['users_birth_date'].toString(),
            );

            emit(LoginSuccess());
          },
        );
      } on Exception catch (e) {
        print(e);
        emit(LoginFailure(e.toString()));
      }
    }
  }
}
