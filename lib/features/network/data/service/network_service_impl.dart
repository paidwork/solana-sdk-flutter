import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:worken_sdk/features/network/data/model/network_status_model.dart';
import 'package:worken_sdk/features/network/domain/service/network_service.dart';
import 'package:worken_sdk/features/network/domain/usecases/get_block_information_usecase.dart';
import 'package:worken_sdk/features/network/domain/usecases/get_fee_rate_usecase.dart';
import 'package:worken_sdk/features/network/domain/usecases/get_monitor_congestion_usecase.dart';

@LazySingleton(as: NetworkService)
class NetworkServiceImpl implements NetworkService {
  @override
  final GetFeeRateUsecase getFeeRateUsecase;
  @override
  final GetMonitorCongestionUsecase getMonitorCongestionUsecase;
  @override
  final GetBlockInformationUsecase getBlockInformationUsecase;

  NetworkServiceImpl({
    required this.getBlockInformationUsecase,
    required this.getFeeRateUsecase,
    required this.getMonitorCongestionUsecase,
  });

  /// Calling our [methods] from usecases we have defined before

  @override
  Future<Block?> blockInformation({required int blockNumber}) async =>
      await getBlockInformationUsecase.call(blockNumber: blockNumber);

  @override
  Future<NetworkStatusModel> networkStatus() async =>
      await getFeeRateUsecase.call();

  @override
  Future<List<PerfSample>> monitorCongestion() async =>
      await getMonitorCongestionUsecase.call();
}
