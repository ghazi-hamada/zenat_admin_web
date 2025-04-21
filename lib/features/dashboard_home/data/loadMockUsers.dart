
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:zenat_admin_web/features/dashboard_home/data/user_model.dart';

Future<List<User>> loadMockUsers() async {
  final data = await rootBundle.loadString('assets/mock_users.json');
  final List<dynamic> jsonResult = json.decode(data);
  return jsonResult.map((item) => User.fromJson(item)).toList();
}
