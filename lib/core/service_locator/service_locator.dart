import 'package:ems_1/core/api/dio_client.dart';
import 'package:ems_1/features/auth/data/datasources/auth_api_datasource.dart';
import 'package:ems_1/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ems_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:ems_1/features/home/data/datasources/event_api_datasource.dart';
import 'package:ems_1/features/home/data/datasources/profile_api_datasource.dart';
import 'package:ems_1/features/home/data/repositories/event_repository_impl.dart';
import 'package:ems_1/features/home/data/repositories/profile_repository_impl.dart';
import 'package:ems_1/features/home/domain/repositories/event_repository.dart';
import 'package:ems_1/features/home/domain/repositories/profile_repository.dart';
import 'package:ems_1/features/home/presentation/cubit/my_event/my_event_cubit.dart';
import 'package:get_it/get_it.dart';

import '../storage/secure_storage_service.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());

  sl.registerLazySingleton<DioClient>(
      () => DioClient(secureStorageService: sl<SecureStorageService>()));

  sl.registerLazySingleton<AuthApiDatasource>(
      () => AuthApiDatasource(dio: sl<DioClient>().instance));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        apiDatasource: sl<AuthApiDatasource>(),
        secureStorageService: sl<SecureStorageService>(),
      ));
  sl.registerLazySingleton<EventApiDatasource>(
      () => EventApiDatasource(dio: sl<DioClient>().instance));

  sl.registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(apiDatasource: sl<EventApiDatasource>()));

  sl.registerLazySingleton<ProfileApiDatasource>(
      () => ProfileApiDatasource(dio: sl<DioClient>().instance));

  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(apiDatasource: sl<ProfileApiDatasource>()));

  sl.registerLazySingleton<MyEventCubit>(
      () => MyEventCubit(sl<EventRepository>()));
}
