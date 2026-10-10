import 'package:bond/config/configs.dart';
import 'package:bond/features/auth/auth.dart';
import 'package:bond_core/bond_core.dart';
import 'package:bond_network/bond_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiServiceProvider extends ServiceProvider {
  /// Dio options from the API configs; the timeouts are in milliseconds.
  static BaseOptions baseOptions() => BaseOptions(
        connectTimeout: Duration(milliseconds: config('CONNECT_TIMEOUT')),
        sendTimeout: Duration(milliseconds: config('SEND_TIMEOUT')),
        receiveTimeout: Duration(milliseconds: config('RECEIVE_TIMEOUT')),
        receiveDataWhenStatusError: config('RECEIVE_DATA_WHEN_STATUS_ERROR'),
        baseUrl: config('API_BASE_URL'),
      );

  @override
  Future<void> register(GetIt it) async {
    final baseOptions = ApiServiceProvider.baseOptions();
    Api.extraHeaders = () {
      return {
        if (Auth.check()) 'Authorization': 'Bearer ${Auth.token()}',
      };
    };
    baseOptions.headers = Api.headers();
    final dio = Dio(baseOptions);
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90),
      );
    }
    it.registerLazySingleton(() => dio);
    // BondFire is a plain class since bond_network 0.1.0; share one instance.
    it.registerLazySingleton<BondFire>(BondFire.new);
    it.registerLazySingleton(() => ApiClient(it()));
  }
}
