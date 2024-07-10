import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:worken_sdk/features/wallet/domain/services/wallet_service.dart';
import 'package:worken_sdk/features/wallet/domain/usecases/balance_usecase.dart';
import 'package:worken_sdk/features/wallet/domain/usecases/create_usecase.dart';
import 'package:worken_sdk/features/wallet/domain/usecases/transactions_usecase.dart';

@LazySingleton(as: WalletService)
class WalletServiceImpl extends WalletService {
  @override
  final BalanceUsecase balanceUsecase;
  @override
  final CreateWalletUsecase createWalletUsecase;
  @override
  final TransactionsUsecase transactionsUsecase;

  WalletServiceImpl({
    required this.balanceUsecase,
    required this.createWalletUsecase,
    required this.transactionsUsecase,
  });

  // calling functions from usecase
  @override
  Future<TokenAmount> getBalance({required String address}) async {
    return await balanceUsecase.call(address: address);
  }

  // calling functions from usecase
  @override
  Future<Ed25519HDKeyPair> createWallet() async {
    return await createWalletUsecase.call();
  }

  // calling functions from usecase
  @override
  Future<List<TransactionSignatureInformation>> getTransactions(
      {required String address}) async {
    return await transactionsUsecase.call(address: address);
  }
}
