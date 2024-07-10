import 'package:injectable/injectable.dart';
import 'package:worken_sdk/features/transaction/domain/repository/transaction_repository.dart';

@lazySingleton
class SendTransactionUsecase {
  final TransactionRepository transactionRepository;

  SendTransactionUsecase({required this.transactionRepository});
  Future<String> call({required String hashString}) async =>
      await transactionRepository.sendTransaction(hashString: hashString);
}
