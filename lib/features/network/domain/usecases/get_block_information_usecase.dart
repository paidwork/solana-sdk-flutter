import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:worken_sdk/features/network/domain/repository/network_repository.dart';

@lazySingleton
class GetBlockInformationUsecase {
  final NetworkRepository networkRepository;

  GetBlockInformationUsecase({required this.networkRepository});

  Future<Block?> call({required int blockNumber}) async =>
      await networkRepository.getBlockInformation(blockNumber: blockNumber);
}
