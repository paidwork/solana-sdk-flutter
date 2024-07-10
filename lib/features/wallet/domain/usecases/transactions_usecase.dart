import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:worken_sdk/features/wallet/domain/repositories/wallet_repository.dart';

@lazySingleton
class TransactionsUsecase {
  final WalletRepository walletRepository;

  TransactionsUsecase({required this.walletRepository});

  Future<List<TransactionSignatureInformation>> call(
      {required String address}) async {
    return await walletRepository.getTransactions(address: address);
  }
}
