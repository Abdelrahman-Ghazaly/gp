import 'package:equatable/equatable.dart';

class SellerEntity extends Equatable {
  final String id;
  final String name;

  const SellerEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
