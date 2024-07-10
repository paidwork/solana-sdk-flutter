import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';
import 'package:worken_sdk/features/wallet/domain/repositories/wallet_repository.dart';

@lazySingleton
class CreateWalletUsecase {
  final WalletRepository walletRepository;

  CreateWalletUsecase({required this.walletRepository});

  Future<Ed25519HDKeyPair> call() async {
    return await walletRepository.createWallet();
  }
}
