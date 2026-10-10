import 'package:bond/app/default_firebase_options.dart';
import 'package:bond/features/update_app/data/models/update_app_default_value.dart';
import 'package:bond_core/bond_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FirebaseServiceProvider extends ServiceProvider {
  @override
  Future<void> register(GetIt it) async {
    final packageInfo = await PackageInfo.fromPlatform();
    it.registerSingleton(packageInfo);
    final firebaseApp = await _initializeFirebase();
    it.registerSingleton(firebaseApp);

    if (!kIsWeb) {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setDefaults(UpdateAppDefaultValue.defaultParameters);
      // Fetched and activated in the background by UpdateAppService, so an
      // offline or slow network doesn't block or abort start-up.
      it.registerLazySingleton(() => remoteConfig);
    }
  }

  Future<FirebaseApp> _initializeFirebase() async {
    try {
      return await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } on FirebaseException catch (error) {
      // The native SDK may already have created the default app from
      // GoogleService-Info.plist / google-services.json with different
      // values (e.g. a placeholder plist); reuse that app.
      if (error.code != 'duplicate-app') rethrow;
      return Firebase.app();
    }
  }
}
