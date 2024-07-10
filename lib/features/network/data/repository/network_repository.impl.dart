import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:worken_sdk/features/network/data/model/network_status_model.dart';
import 'package:worken_sdk/features/network/domain/repository/network_repository.dart';

@LazySingleton(as: NetworkRepository)
class NetworkRepositoryImpl implements NetworkRepository {
  @override

  /// Add our [solanaClient] to use it for datasource
  final SolanaClient solanaClient;

  NetworkRepositoryImpl({required this.solanaClient});

  /// [GetBlockInformation]
  ///
  /// [Functionality]
  ///
  /// Get specified block information
  ///
  /// [Params]
  ///
  /// [int blockNumber]
  ///
  /// [Return]
  ///
  /// [Block] class

  @override
  Future<Block?> getBlockInformation({required int blockNumber}) async {
    try {
      return await solanaClient.rpcClient.getBlock(blockNumber);
    } catch (e) {
      rethrow;
    }
  }

  /// [Get monitor congestion]
  ///
  /// [Functionality]
  ///
  /// Get congestion status of the network
  ///
  /// [Return]
  ///
  /// [List<PerfSample>]

  @override
  Future<List<PerfSample>> getMonitorCongestion() async {
    try {
      return await solanaClient.rpcClient.getRecentPerformanceSamples(5);
    } catch (e) {
      rethrow;
    }
  }

  /// [Get network status]
  ///
  /// [Functionality]
  ///
  /// Get network status information like [block height, fee rate]
  ///
  /// [Return]
  ///
  /// [NetworkStatusModel] class

  @override
  Future<NetworkStatusModel> getNetworkStatus() async {
    try {
      final int blockData = await solanaClient.rpcClient.getBlockHeight();
      final int? feeRate = await solanaClient.rpcClient
          .getFeeForMessage("recent", commitment: Commitment.finalized);

      return NetworkStatusModel(blockData: blockData, feeRate: feeRate);
    } catch (e) {
      rethrow;
    }
  }
}
