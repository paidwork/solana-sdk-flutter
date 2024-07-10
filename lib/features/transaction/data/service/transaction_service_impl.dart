import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:worken_sdk/features/transaction/domain/service/transaction_service.dart';
import 'package:worken_sdk/features/transaction/domain/usecase/get_estimated_fee_usecase.dart';
import 'package:worken_sdk/features/transaction/domain/usecase/get_recent_transactions_usecase.dart';
import 'package:worken_sdk/features/transaction/domain/usecase/get_transaction_status_usecase.dart';
import 'package:worken_sdk/features/transaction/domain/usecase/prepare_transaction_usecase.dart';
import 'package:worken_sdk/features/transaction/domain/usecase/send_transaction_usecase.dart';

@LazySingleton(as: TransactionService)
class TransactionServiceImpl implements TransactionService {
  /// [Invoking our usecases]
  @override
  final GetEstimatedFeeUseCase getEstimatedFeeUseCase;
  @override
  final GetRecentTransactionsUsecase getRecentTransactionsUsecase;
  @override
  final GetTransactionStatusUsecase getTransactionStatusUsecase;
  @override
  final SendTransactionUsecase signAndSendTransactionUsecase;
  @override
  final PrepareTransactionUsecase prepareTransactionUsecase;

  TransactionServiceImpl({
    required this.prepareTransactionUsecase,
    required this.getEstimatedFeeUseCase,
    required this.getRecentTransactionsUsecase,
    required this.getTransactionStatusUsecase,
    required this.signAndSendTransactionUsecase,
  });

  /// [Calling our repository methods]

  @override
  Future<int?> estimatedFee({required String message}) async =>
      await getEstimatedFeeUseCase.call(message: message);

  @override
  Future<List<TransactionSignatureInformation>> recentTransactions(
          {required String mintAddress, required int limit}) async =>
      await getRecentTransactionsUsecase.call(
          mintAddress: mintAddress, limit: limit);

  @override
  Future<String> sendTransaction({required String hashString}) async =>
      await signAndSendTransactionUsecase.call(hashString: hashString);

  @override
  Future<SignatureStatusesResult> transactionStatus(
          {required String signature}) async =>
      await getTransactionStatusUsecase.call(signature: signature);

  @override
  Future<String> prepareTransaction({
    required String sourcePrivateKey,
    required String sourceWallet,
    required String destinationWallet,
    required int amount,
  }) async =>
      await prepareTransactionUsecase.call(
        sourcePrivateKey: sourcePrivateKey,
        sourceWallet: sourceWallet,
        destinationWallet: destinationWallet,
        amount: amount,
      );
}
