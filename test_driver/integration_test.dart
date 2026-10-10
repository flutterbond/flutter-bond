import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver_extended.dart';

/// Host side of `flutter drive --driver=test_driver/integration_test.dart`.
///
/// Saves every `binding.takeScreenshot('<step>')` of the integration test as
/// `build/screenshots/<platform>_<step>.png`, platform being the device OS
/// (`android`, `ios`).
Future<void> main() async {
  final driver = await FlutterDriver.connect();
  final vm = await driver.serviceClient.getVM();
  final platform = vm.operatingSystem ?? 'device';

  await integrationDriver(
    driver: driver,
    onScreenshot: (name, image, [args]) async {
      final file = File('build/screenshots/${platform}_$name.png');
      await file.create(recursive: true);
      await file.writeAsBytes(image);
      return true;
    },
  );
}
