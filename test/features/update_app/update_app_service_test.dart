import 'dart:convert';

import 'package:bond/features/update_app/data/models/current_version.dart';
import 'package:bond/features/update_app/data/models/platform_version.dart';
import 'package:bond/features/update_app/data/models/update_app_default_value.dart';
import 'package:bond/features/update_app/data/update_app_service.dart';
import 'package:bond/features/update_app/routes.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

class _FakeRemoteConfig extends Fake implements FirebaseRemoteConfig {}

void main() {
  final service = UpdateAppService(
    remoteConfig: _FakeRemoteConfig(),
    packageInfo: PackageInfo(
      appName: 'Bond',
      packageName: 'ps.app.bond',
      version: '2.0.0',
      buildNumber: '5',
    ),
  );
  const version = PlatformVersion(
    minVersion: 5,
    maxVersion: 8,
    message: 'Please update',
  );

  test('forces an update only below the minimum version', () {
    expect(service.checkForceUpdate(4, version), isTrue);
    expect(service.checkForceUpdate(5, version), isFalse);
    expect(service.checkForceUpdate(9, version), isFalse);
  });

  test('suggests an update only below the maximum version', () {
    expect(service.checkSoftUpdate(7, version), isTrue);
    expect(service.checkSoftUpdate(8, version), isFalse);
    expect(service.checkSoftUpdate(9, version), isFalse);
  });

  test('the default remote config never asks for an update', () {
    final json = jsonDecode(
      UpdateAppDefaultValue.defaultParameters['appCurrentVersion'] as String,
    ) as Map<String, dynamic>;
    final remote = CurrentVersion.fromJson(json);

    for (final platform in [remote.ios, remote.android]) {
      expect(service.checkForceUpdate(1, platform), isFalse);
      expect(service.checkSoftUpdate(1, platform), isFalse);
    }
  });

  test('update locations carry the message as a query parameter', () {
    const message = 'حان وقت التحديث & more=yes';

    final force = Uri.parse(updateAppLocation(message));
    expect(force.path, '/update_app');
    expect(force.queryParameters['message'], message);

    final soft = Uri.parse(softUpdateLocation(message));
    expect(soft.path, '/soft_update');
    expect(soft.queryParameters['message'], message);
  });
}
