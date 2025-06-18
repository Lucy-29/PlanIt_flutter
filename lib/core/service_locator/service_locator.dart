import 'package:ems_1/core/api/dio_client.dart';
import 'package:ems_1/features/auth/data/datasources/auth_api_datasource.dart';
import 'package:ems_1/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ems_1/features/auth/domain/repositories/auth_repository.dart';
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
}
