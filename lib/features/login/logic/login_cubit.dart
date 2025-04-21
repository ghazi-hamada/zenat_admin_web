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
  PostData postData = PostData(Crud());

  void login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());
      try {
        Either<String, Map<dynamic, dynamic>> response = await postData
            .postData(
              linkurl: AppApiString.LOGIN,
              data: {
                "email": usernameController.text.toString(),
                "password": passwordController.text.toString(),
              },
            );
        print(response);
        response.fold((l) => print(l), (r) => print(r));
        response.fold(
          (l) {
            emit(LoginFailure(l));
          },
          (r) async {
            await SharedPrefHelper.setData(SharedPrefKeys.isLogin, 'true');
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
