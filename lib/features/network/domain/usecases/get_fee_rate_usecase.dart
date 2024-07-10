import 'package:injectable/injectable.dart';
import 'package:worken_sdk/features/network/data/model/network_status_model.dart';
import 'package:worken_sdk/features/network/domain/repository/network_repository.dart';

@lazySingleton
class GetFeeRateUsecase {
  final NetworkRepository networkRepository;

  GetFeeRateUsecase({required this.networkRepository});

  Future<NetworkStatusModel> call() async =>
      await networkRepository.getNetworkStatus();
}
