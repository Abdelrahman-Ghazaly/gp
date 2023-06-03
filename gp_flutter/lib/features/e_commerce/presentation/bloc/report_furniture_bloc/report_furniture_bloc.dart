import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/report_entity.dart';
import 'package:gp_flutter/features/e_commerce/domain/use_cases/product/report_furniture.dart';

import '../../../../../core/error/failure.dart';

part 'report_furniture_event.dart';
part 'report_furniture_state.dart';

class ReportFurnitureBloc
    extends Bloc<ReportFurnitureEvent, ReportFurnitureState> {
  final ReportFurniture reportFurniture;
  ReportFurnitureBloc({required this.reportFurniture}) : super(Empty()) {
    on<ReportFurnitureEvent>((event, emit) async {
      emit(Loading());
      final failureOrString = await reportFurniture(
        Params(
          productId: event.productId,
          accessToken: event.accessToken,
          report: event.report,
        ),
      );
      emit(await _eitherSuccessOrErrorState(failureOrString));
    });
  }
  Future<ReportFurnitureState> _eitherSuccessOrErrorState(
    Either<Failure, String> failureOrString,
  ) async {
    return failureOrString.fold(
      (failure) => Error(message: failure.message),
      (message) => Success(message: message),
    );
  }
}
