import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

abstract class TransactionRepository {
  /// Preparing methods to describe later
  abstract final SolanaClient solanaClient;
  Future<String> prepareTransaction({
    required String sourcePrivateKey,
    required String sourceWallet,
    required String destinationWallet,
    required int amount,
  });
  Future<String> sendTransaction({required String hashString});
  Future<int?> getEstimatedFee({required String message});
  Future<SignatureStatusesResult> getTransactionStatus(
      {required String signature});
  Future<List<TransactionSignatureInformation>> getRecentTransactions(
      {required String mintAddress, required int limit});
}
