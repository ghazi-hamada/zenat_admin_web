import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/core/di/dependency_injection.dart';
import 'package:zenat_admin_web/core/routing/routes.dart';
import 'package:zenat_admin_web/features/dashboard_home/logic/dashboard_home_cubit.dart';
import 'package:zenat_admin_web/features/dashboard_home/ui/dashboard_home_screen.dart';
import 'package:zenat_admin_web/features/login/logic/login_cubit.dart';
import 'package:zenat_admin_web/features/login/ui/login_screen.dart';
import 'package:zenat_admin_web/features/profile/logic/profile_cubit.dart';
import 'package:zenat_admin_web/features/profile/ui/profile_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: LoginScreen(),
              ),
        );
      // case Routes.profile:
      //   return MaterialPageRoute(
      //     builder:
      //         (_) => BlocProvider(
      //           create: (context) => getIt<ProfileCubit>(),
      //           child: ProfileScreen(),
      //         ),
      //   );

      case Routes.dashboard:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => DashboardHomeCubit(),
                child: const DashboardPage(),
              ),
        );
      default:
        return null;
    }
  }
}
