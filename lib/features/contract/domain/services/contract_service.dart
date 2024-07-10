import 'package:solana/dto.dart';
import 'package:worken_sdk/features/contract/domain/usecases/contract_status_usecase.dart';

abstract class ContractService {
  /// Path to deliver information from [contractRepository]
  abstract final ContractStatusUsecase contractStatusUsecase;

  /// Get Worken status
  ///
  /// throws an error occurred in web3dart
  Future<AccountResult> getContractStatus();
}
