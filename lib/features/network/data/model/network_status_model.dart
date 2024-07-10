import 'package:equatable/equatable.dart';

class NetworkStatusModel extends Equatable {
  final int blockData;
  final int? feeRate;

  const NetworkStatusModel({required this.blockData, required this.feeRate});

  @override
  List<Object?> get props => [blockData, feeRate];
}
