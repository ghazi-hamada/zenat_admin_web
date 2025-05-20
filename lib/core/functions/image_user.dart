 
import 'package:zenat_admin_web/core/static/app_api_string.dart';

String imageUser({required String image}) {
  return "${AppApiString.BASE_URL}/upload/users/$image";
}
