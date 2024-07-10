import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

abstract class WalletRepository {
  // Provider to [solanaClient]
  abstract final SolanaClient solanaClient;

  // fuction to get balance of worken from [address]
  Future<TokenAmount> getBalance({required String address});

  // fuction to get transactions of worken from [address]
  Future<List<TransactionSignatureInformation>> getTransactions(
      {required String address});

  // fuction to create wallet on solana
  Future<Ed25519HDKeyPair> createWallet();
}
