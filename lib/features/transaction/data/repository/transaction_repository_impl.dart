import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart' as dto;
import 'package:solana/solana.dart' as sol;
import 'package:worken_sdk/core/token/token_program.dart';
import 'package:worken_sdk/features/transaction/domain/repository/transaction_repository.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  @override
  final sol.SolanaClient solanaClient;

  TransactionRepositoryImpl({required this.solanaClient});

  /// [Prepare transaction]
  ///
  /// [Functionality]
  ///
  /// Prepare transaction in Worken SPL token
  ///
  /// [Params]
  ///
  /// [String]        sourcePrivateKey    Sender private key in base58
  /// [String]        senderWallet        Receiver wallet address
  /// [String]        destinationWallet   Mint address
  /// [int]           amount              Amount to send in WORKEN | 0.00001 Worken = 1
  ///
  /// [Return]
  ///
  /// [String] Transaction hash

  @override
  Future<String> prepareTransaction({
    required String sourcePrivateKey,
    required String sourceWallet,
    required String destinationWallet,
    required int amount,
  }) async {
    try {
      return await TokenProgram().prepareTransaction(
        sourcePrivateKey: sourcePrivateKey,
        senderWallet: sourceWallet,
        destinationWallet: destinationWallet,
        amount: amount,
        solanaClient: solanaClient,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// [Send transaction]
  ///
  /// [Functionality]
  ///
  /// Send prepared transaction
  ///
  /// [Params]
  ///
  /// [String] hashString - prepared transaction hash
  ///
  /// [Return]
  ///
  /// [String] signature hash
  @override
  Future<String> sendTransaction({required String hashString}) async {
    try {
      return await solanaClient.rpcClient.sendTransaction(hashString);
    } catch (e) {
      rethrow;
    }
  }

  /// [Get estimated fee]
  ///
  /// [Functionality]
  ///
  /// Get estimated fee for the transaction
  ///
  /// [Params]
  ///
  /// [String] hashString - prepared transaction hash
  ///
  /// [Return]
  ///
  /// [int] fee
  @override
  Future<int?> getEstimatedFee({required String message}) async {
    try {
      return await solanaClient.rpcClient.getFeeForMessage(
        message,
        commitment: sol.Commitment.processed,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// [Get recent transactions]
  ///
  /// [Functionality]
  ///
  /// Get [limit] recent transactions of the Worken SPL token
  ///
  /// [Params]
  ///
  /// [String] mintAddress - wallet address
  /// [int] limit - amount of transactions to display
  ///
  /// [Return]
  ///
  /// [List<TransactionSignatureInformation>]
  @override
  Future<List<dto.TransactionSignatureInformation>> getRecentTransactions(
      {required String mintAddress, required int limit}) async {
    try {
      return await solanaClient.rpcClient.getSignaturesForAddress(
        mintAddress,
        limit: limit,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// [Get transaction status]
  ///
  /// [Params]
  ///
  /// [String] signature - transaction hash
  ///
  /// [Return]
  ///
  /// [SignatureStatusesResult] class

  @override
  Future<dto.SignatureStatusesResult> getTransactionStatus(
      {required String signature}) async {
    try {
      return await solanaClient.rpcClient.getSignatureStatuses([signature]);
    } catch (e) {
      rethrow;
    }
  }
}
