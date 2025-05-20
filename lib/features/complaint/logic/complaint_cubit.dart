import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zenat_admin_web/core/class/crud.dart';
import 'package:zenat_admin_web/core/class/post_data.dart';
import 'package:zenat_admin_web/core/static/app_api_string.dart';
import 'package:zenat_admin_web/features/complaint/data/complaint_model.dart';

part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  ComplaintCubit() : super(ComplaintInitial());
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  PostData postData = PostData(Crud());
  List<ComplaintModel> complaintData = [];

  void fetchComplaints() async {
    emit(ComplaintLoading());
    var response = await postData.postData(
      linkurl: AppApiString.COMPLAINT,
      data: {},
    );
    response.fold((l) => emit(ComplaintError(l)), (r) {
      if (r['status'] == 'success') {
        complaintData =
            (r['data'] as List).map((e) => ComplaintModel.fromJson(e)).toList();
        emit(ComplaintLoaded(complaintData));
      } else {
        emit(ComplaintError(r['message']));
      }
    });
  }

  void sendEmailToUser({required String email}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(ComplaintLoading());
    try {
      final response = await postData.postData(
        linkurl: AppApiString.SEND_EMAIL_TO_USER,
        data: {
          'emailUser': 'ghazihamada7@gmail.com',
          'subject': subjectController.text,
          'message': messageController.text,
        },
      );
      response.fold((error) => emit(ComplaintError(error)), (result) {
        if (result['status'] == 'success') {
          emit(ComplaintLoaded(complaintData));
        } else {
          emit(ComplaintError(result['message']));
        }
      });
    } catch (e) {
      emit(ComplaintError('حدث خطأ أثناء إرسال الرسالة'));
    }
  }
}
