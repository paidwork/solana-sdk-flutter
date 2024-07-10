import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:worken_sdk/features/contract/domain/repositories/contract_repository.dart';
import 'package:worken_sdk/worken_sdk.dart';

@LazySingleton(as: ContractRepository)
class ContractRepositoryImpl extends ContractRepository {
  @override
  final SolanaClient solanaClient;

  ContractRepositoryImpl({required this.solanaClient});

  @override
  Future<AccountResult> getContractStatus() async {
    try {
      final AccountResult result =
          await solanaClient.rpcClient.getAccountInfo(WorkenSdk.mintAddress);

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
