import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import 'injectable_config.config.dart';

late GetIt locator;

@InjectableInit()
void configureInjectable() => locator.init();

void configureGetIt(SolanaClient provider, GetIt getIt) {
  locator = getIt;

  locator.registerLazySingleton(() => provider);

  configureInjectable();
}
