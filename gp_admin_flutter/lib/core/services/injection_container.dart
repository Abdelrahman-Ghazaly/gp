import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../features/authentication/data/repositories/authenitcation_repository_impl.dart';
import '../../features/authentication/domain/repositories/authentication_repository.dart';
import '../../features/authentication/domain/usecases/log_in.dart';
import '../../features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';

final sl = GetIt.instance;

void init() {
  initBloc();
  initFeatures();
  initRepository();
  initDataSources();
  initExternalPackages();
}

void initBloc() {
  sl.registerFactory(() => LogInBloc(logIn: sl()));
}

void initFeatures() {
  sl.registerLazySingleton(() => LogIn(repository: sl()));
}

void initRepository() {
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenitcationRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );
}

void initDataSources() {
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(
      dio: sl<Dio>(),
    ),
  );
}

void initExternalPackages() {
  sl.registerLazySingleton(() => Dio());
}
