import 'package:plate_scanner_app/core/cache/cache_app.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initInjection() async {
  await initSharedPrefsInjections();
  initAppInjections();
}

initSharedPrefsInjections() async {
  locator.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await locator.isReady<SharedPreferences>();
}

initAppInjections() {
  locator.registerFactory<CacheApp>(() => CacheApp());
}
