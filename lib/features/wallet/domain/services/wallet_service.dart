import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:worken_sdk/features/wallet/domain/usecases/balance_usecase.dart';
import 'package:worken_sdk/features/wallet/domain/usecases/create_usecase.dart';
import 'package:worken_sdk/features/wallet/domain/usecases/transactions_usecase.dart';

abstract class WalletService {
  /// Path to deliver information from [walletRepository]
  abstract final BalanceUsecase balanceUsecase;

  /// Path to deliver information from [walletRepository]
  abstract final TransactionsUsecase transactionsUsecase;

  /// Path to deliver information from [walletRepository]
  abstract final CreateWalletUsecase createWalletUsecase;

  /// Get balance WORK tokens of given wallet [address]
  ///
  /// throws an error occurred in web3dart
  Future<TokenAmount> getBalance({required String address});

  /// Get transaction from WORK tokens of given wallet [address]
  ///
  /// throws an error occurred in web3dart
  Future<List<TransactionSignatureInformation>> getTransactions(
      {required String address});

  /// Create wallet on solana
  ///
  /// throws an error occurred in web3dart
  Future<Ed25519HDKeyPair> createWallet();
}
