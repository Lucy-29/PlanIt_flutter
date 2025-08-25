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
import 'package:ems_1/features/company/data/datasources/company_api_datasource.dart';
import 'package:ems_1/features/company/data/repositories/company_repository_impl.dart';
import 'package:ems_1/features/company/domain/repositories/company_repository.dart';
import 'package:ems_1/features/company/presentation/cubit/profile/company_profile_cubit.dart';
import 'package:ems_1/features/company/presentation/cubit/events/company_events_cubit.dart';
import 'package:ems_1/features/company/presentation/cubit/gallery/company_gallery_cubit.dart';
import 'package:ems_1/features/company/presentation/cubit/statistics/company_statistics_cubit.dart';
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

  // Company dependencies
  sl.registerLazySingleton<CompanyApiDatasource>(
      () => CompanyApiDatasource(dio: sl<DioClient>().instance));

  sl.registerLazySingleton<CompanyRepository>(
      () => CompanyRepositoryImpl(apiDatasource: sl<CompanyApiDatasource>()));

  sl.registerFactory<CompanyProfileCubit>(
      () => CompanyProfileCubit(repository: sl<CompanyRepository>()));

  sl.registerFactory<CompanyEventsCubit>(
      () => CompanyEventsCubit(repository: sl<CompanyRepository>()));

  sl.registerFactory<CompanyGalleryCubit>(
      () => CompanyGalleryCubit(repository: sl<CompanyRepository>()));

  sl.registerFactory<CompanyStatisticsCubit>(
      () => CompanyStatisticsCubit(repository: sl<CompanyRepository>()));
}
