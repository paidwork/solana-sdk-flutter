import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:worken_sdk/features/network/data/model/network_status_model.dart';

abstract class NetworkRepository {
  /// Preparing details to describe later in our repositoryImpl
  abstract final SolanaClient solanaClient;
  Future<NetworkStatusModel> getNetworkStatus();
  Future<Block?> getBlockInformation({required int blockNumber});
  Future<List<PerfSample>> getMonitorCongestion();
}
