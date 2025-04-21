 

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart'; // عشان kIsWeb

Future<bool> checkInternet() async {
  // للويب، نعتبر فيه اتصال (أو اعمل ping لـ API بسيط لو تحب)
  if (kIsWeb) {
    return true;
  }

  var connectivityResult = await Connectivity().checkConnectivity();

  // إذا فيه اتصال بأي شبكة (واي فاي أو داتا)
  return connectivityResult != ConnectivityResult.none;
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
