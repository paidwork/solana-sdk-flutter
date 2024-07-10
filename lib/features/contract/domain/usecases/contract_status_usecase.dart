import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:worken_sdk/features/contract/domain/repositories/contract_repository.dart';

@lazySingleton
class ContractStatusUsecase {
  final ContractRepository contractRepository;

  ContractStatusUsecase({required this.contractRepository});

  Future<AccountResult> call() async {
    return await contractRepository.getContractStatus();
  }
}
