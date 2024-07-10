import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:worken_sdk/features/contract/domain/services/contract_service.dart';
import 'package:worken_sdk/features/contract/domain/usecases/contract_status_usecase.dart';

@LazySingleton(as: ContractService)
class ContractServiceImpl extends ContractService {
  @override
  final ContractStatusUsecase contractStatusUsecase;

  ContractServiceImpl({required this.contractStatusUsecase});

  @override
  Future<AccountResult> getContractStatus() async {
    return await contractStatusUsecase.call();
  }
}
