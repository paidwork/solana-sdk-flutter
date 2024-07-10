import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:worken_sdk/features/network/domain/repository/network_repository.dart';

@lazySingleton
class GetMonitorCongestionUsecase {
  final NetworkRepository networkRepository;

  GetMonitorCongestionUsecase({required this.networkRepository});

  Future<List<PerfSample>> call() async =>
      await networkRepository.getMonitorCongestion();
}
