import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:worken_sdk/features/transaction/domain/repository/transaction_repository.dart';

@lazySingleton
class GetTransactionStatusUsecase {
  final TransactionRepository transactionRepository;

  GetTransactionStatusUsecase({required this.transactionRepository});

  Future<SignatureStatusesResult> call({required String signature}) async =>
      await transactionRepository.getTransactionStatus(signature: signature);
}
