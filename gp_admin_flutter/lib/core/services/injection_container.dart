import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gp_admin_flutter/features/auction/domain/usecases/accept_auction_usecase.dart';
import 'package:gp_admin_flutter/features/auction/domain/usecases/refuse_auction_usecase.dart';
import 'package:gp_admin_flutter/features/auction/presentation/bloc/get_all_auctions_bloc/all_auctions_bloc.dart';
import 'package:gp_admin_flutter/features/reports/data/repositories/auction_repository.dart';
import 'package:gp_admin_flutter/features/reports/domain/repositories/base_report_repository.dart';
import 'package:gp_admin_flutter/features/reports/presentation/bloc/accept_refuse_report_bloc/request_report_bloc.dart';
import 'package:gp_admin_flutter/features/reports/presentation/bloc/get_all_reports_bloc/all_reports_bloc.dart';

import '../../features/auction/data/datasources/auction_reomte_data_source.dart';
import '../../features/auction/data/repositories/auction_repository.dart';
import '../../features/auction/domain/repositories/base_auction_repository.dart';
import '../../features/auction/domain/usecases/get_auction_products_usecase.dart';
import '../../features/auction/presentation/bloc/request_austion_bloc/request_auction_bloc.dart';
import '../../features/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../features/authentication/data/repositories/authenitcation_repository_impl.dart';
import '../../features/authentication/domain/repositories/authentication_repository.dart';
import '../../features/authentication/domain/usecases/log_in.dart';
import '../../features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import '../../features/reports/data/datasources/report_reomte_data_source.dart';
import '../../features/reports/domain/usecases/accept_report_usecase.dart';
import '../../features/reports/domain/usecases/refuse_report_usecase.dart';

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
  sl.registerFactory(() => AllAuctionsBloc(
        getAuctionProductsUseCase: sl(),
      ));
  sl.registerFactory(() => RequestAuctionBloc(
      acceptAuctionUseCase: sl(), refuseAuctionUseCase: sl()));
  sl.registerFactory(() => AllReportsBloc(
        getReportsUseCase: sl(),
      ));
  sl.registerFactory(() =>
      RequestReportsBloc(acceptReportUseCase: sl(), refuseReportUseCase: sl()));
}

void initFeatures() {
  sl.registerLazySingleton(() => LogIn(repository: sl()));
  sl.registerLazySingleton(() => GetAuctionProductsUseCase(sl()));
  sl.registerLazySingleton(() => AcceptAuctionUseCase(sl()));
  sl.registerLazySingleton(() => RefuseAuctionUseCase(sl()));
  sl.registerLazySingleton(() => AcceptReportUseCase(sl()));
  sl.registerLazySingleton(() => RefuseReportUseCase(sl()));
}

void initRepository() {
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenitcationRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<BaseAuctionRepository>(
      () => AuctionRepository(sl()));
  sl.registerLazySingleton<BaseReportRepository>(() => ReportsRepository(sl()));
}

void initDataSources() {
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(
      dio: sl<Dio>(),
    ),
  );
  sl.registerLazySingleton<BaseAuctionRemoteDataSource>(
    () => AuctionRemoteDataSource(
      dio: sl<Dio>(),
    ),
  );
  sl.registerLazySingleton<BaseReportRemoteDataSource>(
    () => ReportRemoteDataSource(
      dio: sl<Dio>(),
    ),
  );
}

void initExternalPackages() {
  sl.registerLazySingleton(() => Dio());
}
