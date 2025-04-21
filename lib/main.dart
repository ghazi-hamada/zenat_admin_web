import 'package:flutter/material.dart';
import 'package:zenat_admin_web/core/di/dependency_injection.dart';
import 'package:zenat_admin_web/core/functions/check_internet.dart';
import 'package:zenat_admin_web/core/helper/constants.dart';
import 'package:zenat_admin_web/core/helper/shared_pref_helper.dart';
import 'package:zenat_admin_web/core/routing/app_router.dart';
import 'package:zenat_admin_web/core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkIfLoggedInUser();
  setupGetIt();
  runApp(  ZenatDashboardApp(appRouter: AppRouter(),));
}

class ZenatDashboardApp extends StatelessWidget {
  final AppRouter appRouter;
  const ZenatDashboardApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لوحة تحكم زينات',
      theme: ThemeData(
        primaryColor: const Color(0xFFFB962B),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFB962B),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Cairo',
      ),
      initialRoute: isLoggedInUser ? Routes.dashboard : Routes.loginScreen,
       onGenerateRoute: appRouter.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

checkIfLoggedInUser() async {
  String? isLogin = await SharedPrefHelper.getString(
    SharedPrefKeys.isLogin,
  );
  if (!isLogin.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
