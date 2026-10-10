import 'package:bond/config/configs.dart';
import 'package:bond/providers/api_service_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('timeouts default to 10 s connect and 30 s send/receive', () {
    expect(config('CONNECT_TIMEOUT'), 10000);
    expect(config('SEND_TIMEOUT'), 30000);
    expect(config('RECEIVE_TIMEOUT'), 30000);
  });

  test('timeouts are read as milliseconds', () {
    final options = ApiServiceProvider.baseOptions();

    expect(options.connectTimeout, const Duration(seconds: 10));
    expect(options.sendTimeout, const Duration(seconds: 30));
    expect(options.receiveTimeout, const Duration(seconds: 30));
  });

  test('unknown keys throw', () {
    expect(() => config('MISSING'), throwsException);
  });
}
