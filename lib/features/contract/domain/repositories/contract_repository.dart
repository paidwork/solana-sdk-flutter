import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

abstract class ContractRepository {
  // Provider to [SolanaClient]
  abstract final SolanaClient solanaClient;

  // fuction to get contract status
  Future<AccountResult> getContractStatus();
}
