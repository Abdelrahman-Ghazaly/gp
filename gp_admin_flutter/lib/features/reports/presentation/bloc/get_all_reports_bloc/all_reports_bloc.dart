import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_admin_flutter/features/reports/domain/entities/report_entity.dart';
import 'package:gp_admin_flutter/features/reports/domain/usecases/get_reports_usecase.dart';

import '../../../../../core/error/failure.dart';

part 'all_reports_event.dart';
part 'all_reports_state.dart';

class AllReportsBloc extends Bloc<AllReportsEvent, AllReportsState> {
  final GetReportsUseCase getReportsUseCase;

  AllReportsBloc({required this.getReportsUseCase}) : super(Loading()) {
    on<GetReportsEvent>((event, emit) async {
      emit(Loading());
      final failureOrAuctionList = await getReportsUseCase(event.adminToken);

      emit(await _eitherLoadedOrErrorState(failureOrAuctionList));
    });
    on<UpdateReportsList>((event, emit) async {
      emit(Loaded(reportList: event.reportList));
    });
  }
}

Future<AllReportsState> _eitherLoadedOrErrorState(
  Either<Failure, List<ReportEntity>> failureOrAuctionList,
) async {
  return failureOrAuctionList.fold(
    (failure) => Error(message: failure.message),
    (auctionList) {
      return Loaded(reportList: auctionList);
    },
  );
}
