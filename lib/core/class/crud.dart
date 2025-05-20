import 'dart:convert';
import 'dart:developer';


import '../functions/check_internet.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dartz/dartz.dart';

class Crud {
  final Dio _dio;

  Crud()
    : _dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          responseType: ResponseType.json,
        ),
      ) {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false, // Response headers are often not needed.
        responseBody: true,
        compact: true, // Keeps logs concise.
        maxWidth: 120, // Adjust width for better readability.
      ),
    );
  }

  Future<Either<String, Map<String, dynamic>>> postData(
    String linkUrl,
    Map<String, dynamic> data,
  ) async {
    log("Request Data: ${jsonEncode(data)}", name: "POST Request");

    if (!await checkInternet()) {
      return const Left(
        "لا يوجد اتصال بالإنترنت. تحقق من اتصالك وحاول مرة أخرى.",
      );
    }

    try {
      final response = await _dio.post(
        linkUrl,
        data: FormData.fromMap(data),
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            'Authorization': 'Bearer s9TkN2vBq7XjL4gPfWdR6mZoCvYeHtKm',
          },
        ),
      );
      final responseData = jsonDecode(response.data);

      if (responseData['status'] == 'success') {
        log("Response Data: $responseData", name: "Response");
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.data);

        if (responseData['status'] == 'success') {
          return Right(responseData);
        }
        return Left(responseData['message'] ?? "حدث خطأ غير متوقع.");
      }

      return Left(_handleHttpError(response.statusCode));
    } on DioException catch (e) {
      log("DioError: ${e.message}", name: "DioException");
      log("DioError Data: ${e.response?.data}", name: "DioException");
      return Left(
        e.response?.data?['message']?.toString() ?? "حدث خطأ غير متوقع.",
      );
    } catch (e, stackTrace) {
      log(
        "Unexpected Error: $e",
        name: "Unexpected Exception",
        error: e,
        stackTrace: stackTrace,
      );
      return const Left("حدث خطأ غير متوقع. يرجى المحاولة لاحقًا.");
    }
  }

  String _handleHttpError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "الطلب غير صحيح. يرجى التحقق من البيانات المدخلة.";
      case 401:
        return "أنت غير مخول للوصول إلى هذا المورد.";
      case 403:
        return "ليس لديك إذن للوصول إلى هذا المورد.";
      case 404:
        return "المورد غير موجود. تحقق من الرابط وحاول مرة أخرى.";
      case 500:
        return "حدث خطأ في الخادم. يرجى المحاولة لاحقًا.";
      default:
        return "حدث خطأ غير متوقع. يرجى المحاولة لاحقًا.";
    }
  }
}
