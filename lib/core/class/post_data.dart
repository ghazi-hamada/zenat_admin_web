import 'dart:convert';
import 'dart:developer';
import 'dart:io'; // لإدارة الملفات

import 'package:dartz/dartz.dart'; // استيراد مكتبة dartz
import 'package:http/http.dart' as http;

import 'crud.dart';

class PostData {
  Crud crud;
  PostData(this.crud);

  Future<Either<String, Map>> postData({
    required String linkurl,
    required Map<String, dynamic> data,
    File? file, // دعم رفع الملفات
  }) async {
    try {
      if (file != null) {
        // إذا كان هناك ملف، استخدم MultipartRequest
        var uri = Uri.parse(linkurl);
        var request = http.MultipartRequest('POST', uri);

        // إضافة الملف
        request.files.add(
          await http.MultipartFile.fromPath(
            'files', // اسم المفتاح المستخدم في PHP
            file.path,
          ),
        );

        // إضافة البيانات الأخرى
        data.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        // إرسال الطلب
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        // تحويل الاستجابة إلى خريطة (Map) وفحص المفتاح 'status'
        if (response.statusCode == 200) {
          var responseMap = jsonDecode(response.body);

          // تحقق من قيمة 'status'
          if (responseMap['status'] == 'success') {
            return Right(responseMap); // إذا كانت الاستجابة ناجحة
          } else {
            return Left(
              "Failure: ${responseMap['message'] ?? 'Unknown error'}",
            ); // إذا كانت الاستجابة فاشلة
          }
        } else {
          return Left("Error: ${response.statusCode}");
        }
      } else {
        // إذا لم يكن هناك ملف، استخدم الطلب العادي
        Either<String, Map<String, dynamic>> response = await crud.postData(
          linkurl,
          data,
        );

        return response.fold(
          (l) => Left(l), // إذا كان هناك خطأ
          (r) => Right(r), // إذا كانت الاستجابة ناجحة
        );
      }
    } catch (e) {
      log("Error: $e");
      return Left("Exception: $e");
    }
  }
}
