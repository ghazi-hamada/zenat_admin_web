import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zenat_admin_web/features/settings/logic/members/members_cubit.dart';
import 'package:zenat_admin_web/features/settings/logic/settings_cubit.dart';
import 'package:zenat_admin_web/features/stories/logic/stories_cubit.dart';
import 'package:zenat_admin_web/features/subscriptions/logic/subscriptions_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:zenat_admin_web/core/di/dependency_injection.dart';
import 'package:zenat_admin_web/core/functions/check_internet.dart';
import 'package:zenat_admin_web/core/helper/constants.dart';
import 'package:zenat_admin_web/core/helper/shared_pref_helper.dart';
import 'package:zenat_admin_web/core/routing/app_router.dart';
import 'package:zenat_admin_web/core/routing/routes.dart';
import 'package:zenat_admin_web/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/features/complaint/logic/complaint_cubit.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  await checkIfLoggedInUser();
  setupGetIt();
  runApp(ZenatDashboardApp(appRouter: AppRouter()));
}

class ZenatDashboardApp extends StatelessWidget {
  final AppRouter appRouter;
  const ZenatDashboardApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ComplaintCubit>(create: (context) => ComplaintCubit()),
        BlocProvider<StoriesCubit>(create: (context) => StoriesCubit()),
        BlocProvider<SubscriptionsCubit>(
          create: (context) => SubscriptionsCubit(),
        ),
        BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
        BlocProvider<MembersCubit>(create: (context) => MembersCubit()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('ar'), // Arabic
          // أضف غيرها حسب احتياجك
        ],
        locale: Locale('en'), // اللغة الافتراضية (اختياري)

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
        initialRoute: !isLoggedInUser ? Routes.dashboard : Routes.loginScreen,
        onGenerateRoute: appRouter.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

checkIfLoggedInUser() async {
  String? isLogin = await SharedPrefHelper.getString(SharedPrefKeys.isLogin);
  if (!isLogin.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
