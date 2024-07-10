import 'package:injectable/injectable.dart';
import 'package:worken_sdk/features/transaction/domain/repository/transaction_repository.dart';

@lazySingleton
class GetEstimatedFeeUseCase {
  final TransactionRepository transactionRepository;

  GetEstimatedFeeUseCase({required this.transactionRepository});

  Future<int?> call({required String message}) async =>
      await transactionRepository.getEstimatedFee(message: message);
}
