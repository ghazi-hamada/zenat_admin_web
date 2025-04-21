 import 'package:get_it/get_it.dart';
import 'package:zenat_admin_web/features/login/logic/login_cubit.dart';
final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService

  // login
   getIt.registerFactory<LoginCubit>(() => LoginCubit());


  // home
  // getIt.registerLazySingleton<HomeApiService>(() => HomeApiService(dio));
  // getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
}
