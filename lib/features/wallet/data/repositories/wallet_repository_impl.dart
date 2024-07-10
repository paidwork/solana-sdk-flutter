import 'package:bip39/bip39.dart' as bip39;
import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:worken_sdk/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:worken_sdk/worken_sdk.dart';

@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl extends WalletRepository {
  @override
  final SolanaClient solanaClient;

  WalletRepositoryImpl({required this.solanaClient});

  /// [getBalance]
  /// Get balance of WORK token for a given wallet address
  /// [address] is wallet adress
  /// return object [TokenAmount]
  @override
  Future<TokenAmount> getBalance({required String address}) async {
    try {
      // get publicKey from [address]
      final publicKey = Ed25519HDPublicKey.fromBase58(address);
      // get contract Adress
      final contractAdress =
          Ed25519HDPublicKey.fromBase58(WorkenSdk.mintAddress);

      // get [TokenAmount] from [solanaClient]
      final TokenAmount result = await solanaClient.getTokenBalance(
        owner: publicKey,
        mint: contractAdress,
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }

  /// [getTransactions]
  /// Get history of transactions for a given wallet address
  /// [address] is wallet adress
  /// return list of [TransactionSignatureInformation]
  @override
  Future<List<TransactionSignatureInformation>> getTransactions(
      {required String address}) async {
    try {
      final result =
          await solanaClient.rpcClient.getSignaturesForAddress(address);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Ed25519HDKeyPair> createWallet() async {
    try {
      final mnemonic = bip39.generateMnemonic();

      final result = await Wallet.fromMnemonic(mnemonic);

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
