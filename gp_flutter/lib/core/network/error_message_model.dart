import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final int statusCode;
  final String statusMessage;

  const ErrorMessageModel({
    required this.statusCode,
    required this.statusMessage,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      statusCode: json['status_code'] ?? 0,
      statusMessage: json['status_message'] ?? 'Something went wrong',
    );
  }

  @override
  List<Object> get props => [statusCode, statusMessage];
}
