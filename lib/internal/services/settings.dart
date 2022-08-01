import 'dart:convert';

import 'package:crypto_signals_july/domain/models/signals_data/signals_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Settings {
  static const String appName = 'Crypto Trading & Signals';

  static const signalsDataKey = 'signals_data';

  static const defaultWebviewUrl = 'https://google.com';

  /// Зашифрованное хранилище локальных данных.
  late FlutterSecureStorage _storage;
  late Map<String, String> _secureValues;
  late Map<String, RemoteConfigValue> _configValues;

  RemoteConfig get remoteConfig => RemoteConfig.instance;

  Future<void> initFirebase() async {
    await Firebase.initializeApp();

    try {
      await remoteConfig.fetchAndActivate();
      _configValues = remoteConfig.getAll();
    } catch (e) {
      remoteConfig.setDefaults({
        'webview_url': defaultWebviewUrl,
      });

      _configValues = remoteConfig.getAll();
    }
  }

  Future initStorage() async {
    _storage = const FlutterSecureStorage();
    _secureValues = await _storage.readAll();
  }

  String get webviewUrl => _configValues['webview_url']?.asString() ?? defaultWebviewUrl;

  SignalsData get signalsData =>
      (SignalsData.fromJson((jsonDecode(_secureValues[signalsDataKey] ?? '') as Map<String, dynamic>)));
  set signalsData(SignalsData data) {
    final _data = jsonEncode(data.toJson());

    _secureValues[signalsDataKey] = _data;
    _storage.write(key: signalsDataKey, value: _data);
  }
}
