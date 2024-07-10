library worken_sdk;

import 'package:get_it/get_it.dart';
import 'package:solana/solana.dart';
import 'package:worken_sdk/core/di/injectable_config.dart';
import 'package:worken_sdk/core/error/exceptions.dart';
import 'package:worken_sdk/core/types/solana_net.dart';
import 'package:worken_sdk/features/contract/domain/services/contract_service.dart';
import 'package:worken_sdk/features/network/domain/service/network_service.dart';
import 'package:worken_sdk/features/transaction/domain/service/transaction_service.dart';
import 'package:worken_sdk/features/wallet/domain/services/wallet_service.dart';

// WorkenSdk its main class to setup sdk
class WorkenSdk {
  // $Work mint address
  static String mintAddress = "9tnkusLJaycWpkzojAk5jmxkdkxBHRkFNVSsa7tPUgLb";

  /// Setup sdk
  ///
  /// if [provider] is null, please set [typeNet] is type of solana url
  /// ...
  ///
  static setup({
    SolanaNet? typeNet,
    SolanaClient? provider,
    GetIt? locator,
  }) {
    if (typeNet == null && provider == null) {
      throw WorkenException(
          message: "WorkenSdk | if provider is null, set typeNet");
    }

    final solanaClient = provider ??
        SolanaClient(
          rpcUrl: typeNet?.toUri ?? SolanaNet.mainNet.toUri,
          websocketUrl: typeNet?.toUri ?? SolanaNet.mainNet.toUri,
        );

    configureGetIt(
      solanaClient,
      locator ?? GetIt.instance,
    );
  }

  // get [WalletService] from [locator]
  static WalletService getWalletService() => locator.get<WalletService>();

  // get [NetworkService] from [locator]
  static NetworkService getNetworkService() => locator.get<NetworkService>();

  // get [ContractService] from [locator]
  static ContractService getContractService() => locator.get<ContractService>();

  // get [TransactionService] from [locator]
  static TransactionService getTransactionService() =>
      locator.get<TransactionService>();
}
