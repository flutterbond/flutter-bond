import 'dart:convert';
import 'dart:developer';

import 'package:bond_cache/bond_cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageCacheDriver extends CacheDriver {
  final FlutterSecureStorage _storage;

  SecureStorageCacheDriver(this._storage);

  var _cache = <String, dynamic>{};

  Future<SecureStorageCacheDriver> loadAll() async {
    _cache = await _storage.readAll();
    return this;
  }

  @override
  Map<String, dynamic>? retrieve(String key) {
    try {
      final jsonString = _cache[key];
      if (jsonString == null) {
        return null;
      }
      return jsonDecode(jsonString);
    } catch (error, stack) {
      log('retrieve error: $error , stackTrace : $stack');
      return null;
    }
  }

  @override
  Future<bool> store(String key, Map<String, dynamic> data) async {
    try {
      final jsonString = jsonEncode(data);
      await _storage.write(key: key, value: jsonString);
      return true;
    } catch (error, stack) {
      log('store error: $error , stackTrace : $stack');
      return false;
    } finally {
      await loadAll();
    }
  }

  @override
  bool has(String key) => _cache.containsKey(key);

  @override
  Future<bool> removeAll() async {
    try {
      await _storage.deleteAll();
      return true;
    } catch (error, stack) {
      log('flush error: $error , stackTrace : $stack');
      return false;
    } finally {
      await loadAll();
    }
  }

  @override
  Future<bool> remove(String key) async {
    try {
      await _storage.delete(key: key);
      return true;
    } catch (error, stack) {
      log('forget error: $error , stackTrace : $stack');
      return false;
    } finally {
      await loadAll();
    }
  }
}
