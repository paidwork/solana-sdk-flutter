import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:worken_sdk/features/wallet/domain/repositories/wallet_repository.dart';

@lazySingleton
class BalanceUsecase {
  final WalletRepository walletRepository;

  BalanceUsecase({required this.walletRepository});

  Future<TokenAmount> call({required String address}) async {
    return await walletRepository.getBalance(address: address);
  }
}
