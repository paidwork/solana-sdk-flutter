import 'package:solana/dto.dart';
import 'package:worken_sdk/features/network/data/model/network_status_model.dart';
import 'package:worken_sdk/features/network/domain/usecases/get_block_information_usecase.dart';
import 'package:worken_sdk/features/network/domain/usecases/get_fee_rate_usecase.dart';
import 'package:worken_sdk/features/network/domain/usecases/get_monitor_congestion_usecase.dart';

abstract class NetworkService {
  ///Get network information from our [solana usecases]
  abstract final GetBlockInformationUsecase getBlockInformationUsecase;
  abstract final GetFeeRateUsecase getFeeRateUsecase;
  abstract final GetMonitorCongestionUsecase getMonitorCongestionUsecase;

  /// Get [fee rate] for operation
  Future<NetworkStatusModel> networkStatus();

  /// Get [block information] with required value of [blockNumber]
  Future<Block?> blockInformation({required int blockNumber});

  /// Get information about [monitor congestion]
  Future<List<PerfSample>> monitorCongestion();
}
