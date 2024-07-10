import 'package:injectable/injectable.dart';
import 'package:worken_sdk/features/transaction/domain/repository/transaction_repository.dart';

@lazySingleton
class PrepareTransactionUsecase {
  final TransactionRepository transactionRepository;

  PrepareTransactionUsecase({required this.transactionRepository});

  Future<String> call({
    required String sourcePrivateKey,
    required String sourceWallet,
    required String destinationWallet,
    required int amount,
  }) async =>
      await transactionRepository.prepareTransaction(
        sourcePrivateKey: sourcePrivateKey,
        sourceWallet: sourceWallet,
        destinationWallet: destinationWallet,
        amount: amount,
      );
}
