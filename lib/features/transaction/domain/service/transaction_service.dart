import 'package:solana/dto.dart';
import 'package:worken_sdk/features/transaction/domain/usecase/get_estimated_fee_usecase.dart';
import 'package:worken_sdk/features/transaction/domain/usecase/get_recent_transactions_usecase.dart';
import 'package:worken_sdk/features/transaction/domain/usecase/get_transaction_status_usecase.dart';
import 'package:worken_sdk/features/transaction/domain/usecase/prepare_transaction_usecase.dart';
import 'package:worken_sdk/features/transaction/domain/usecase/send_transaction_usecase.dart';

abstract class TransactionService {
  /// Describing service details to invoke later
  abstract final GetEstimatedFeeUseCase getEstimatedFeeUseCase;
  abstract final GetRecentTransactionsUsecase getRecentTransactionsUsecase;
  abstract final GetTransactionStatusUsecase getTransactionStatusUsecase;
  abstract final SendTransactionUsecase signAndSendTransactionUsecase;
  abstract final PrepareTransactionUsecase prepareTransactionUsecase;

  Future<int?> estimatedFee({required String message});

  Future<List<TransactionSignatureInformation>> recentTransactions(
      {required String mintAddress, required int limit});

  Future<SignatureStatusesResult> transactionStatus(
      {required String signature});

  Future<String> prepareTransaction({
    required String sourcePrivateKey,
    required String sourceWallet,
    required String destinationWallet,
    required int amount,
  });

  Future<String> sendTransaction({required String hashString});
}
