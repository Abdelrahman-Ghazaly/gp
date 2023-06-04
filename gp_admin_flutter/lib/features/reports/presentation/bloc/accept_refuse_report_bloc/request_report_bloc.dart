import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';

import '../../../domain/usecases/accept_report_usecase.dart' as accept_report;
import '../../../domain/usecases/refuse_report_usecase.dart' as refuse_report;

part 'request_report_event.dart';
part 'request_report_state.dart';

class RequestReportsBloc extends Bloc<RequestReportEvent, RequestReportState> {
  final accept_report.AcceptReportUseCase acceptReportUseCase;
  final refuse_report.RefuseReportUseCase refuseReportUseCase;
  RequestReportsBloc({
    required this.acceptReportUseCase,
    required this.refuseReportUseCase,
  }) : super(Empty()) {
    on<AcceptReportEvent>((event, emit) async {
      final failureOrAuctionList = await acceptReportUseCase(
          accept_report.Params(
              adminToken: event.adminToken, productId: event.auctionId));

      emit(await _eitherSuccessOrErrorState(failureOrAuctionList));
    });
    on<RefuseReportEvent>((event, emit) async {
      final failureOrAuctionList = await refuseReportUseCase(
          refuse_report.Params(
              adminToken: event.adminToken, productId: event.auctionId));

      emit(await _eitherSuccessOrErrorState(failureOrAuctionList));
    });
  }
  Future<RequestReportState> _eitherSuccessOrErrorState(
    Either<Failure, String> failureOrString,
  ) async {
    return failureOrString.fold(
      (failure) => Error(message: failure.message),
      (message) => Success(message: message),
    );
  }
}
