import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:worken_sdk/features/transaction/domain/repository/transaction_repository.dart';

@lazySingleton
class GetRecentTransactionsUsecase {
  final TransactionRepository transactionRepository;

  GetRecentTransactionsUsecase({required this.transactionRepository});

  Future<List<TransactionSignatureInformation>> call(
          {required String mintAddress, required int limit}) async =>
      await transactionRepository.getRecentTransactions(
          mintAddress: mintAddress, limit: limit);
}
