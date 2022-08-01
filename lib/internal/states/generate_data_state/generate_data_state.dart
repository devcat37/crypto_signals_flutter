import 'dart:math';

import 'package:crypto_signals_july/domain/mocks/mock_currencies.dart';
import 'package:crypto_signals_july/domain/models/currency/currency.dart';
import 'package:crypto_signals_july/domain/models/signal/signal.dart';
import 'package:crypto_signals_july/domain/models/signals_data/signals_data.dart';
import 'package:crypto_signals_july/internal/services/service_locator.dart';
import 'package:crypto_signals_july/internal/services/settings.dart';
import 'package:mobx/mobx.dart';

part 'generate_data_state.g.dart';

class GenerateDataState = _GenerateDataStateBase with _$GenerateDataState;

abstract class _GenerateDataStateBase with Store {
  /// Информация будет добавляться в текущую каждые [_updatePeriod].
  static const Duration _updatePeriod = Duration(minutes: 4);

  static const int _fullUpdateCycles = 8;

  @observable
  DateTime lastUpdate = DateTime.now();

  @observable
  ObservableList<Signal> currencySignals = ObservableList();

  @computed
  ObservableList<Signal> get freeSignals => ObservableList.of(currencySignals.where((e) => !e.isPremium));

  @computed
  ObservableList<Signal> get premiumSignals => ObservableList.of(currencySignals.where((e) => e.isPremium));

  Future<void> _generateCurrencies({bool small = false}) async {
    final int currenciesCount = Random().nextInt(5) + (small ? 0 : 5);

    for (int i = 0; i < currenciesCount; i++) {
      final Currency one = allMockCurencies[Random().nextInt(allMockCurencies.length)];
      final Currency two = allMockCurencies
          .where((e) => e != one)
          .toList()[Random().nextInt(allMockCurencies.where((e) => e != one).toList().length)];

      currencySignals.insert(
        0,
        Signal(
          one: one,
          two: two,
          date: DateTime.now(),
          type: SignalType.values[Random().nextInt(SignalType.values.length)],
          period: SignalPeriod.values[Random().nextInt(SignalPeriod.values.length)],
          isPremium: Random().nextBool(),
        ),
      );
    }
  }

  Future<void> _generateData({bool small = false}) async {
    await _generateCurrencies(small: small);

    service<Settings>().signalsData = SignalsData(
      currencySignals: currencySignals,
      lastUpdate: lastUpdate,
    );
  }

  Future<void> _clearData() async {
    currencySignals.clear();
  }

  Future<void> _handleDataUpdate() async {
    print('Время с последнего обновления: ${(DateTime.now().difference(lastUpdate)).inMinutes} min');
    _generateData(small: currencySignals.isNotEmpty);

    if ((DateTime.now().difference(lastUpdate)).inMinutes >= _fullUpdateCycles * _updatePeriod.inMinutes) {
      lastUpdate = DateTime.now();
      await _clearData();
      await _generateData();
    }
  }

  Future<void> _loadCachedData() async {
    try {
      final SignalsData data = service<Settings>().signalsData;

      currencySignals = data.currencySignals.asObservable();
      lastUpdate = data.lastUpdate;
    } catch (_) {}
  }

  Future<void> initialize() async {
    await _loadCachedData();

    // Если данные не загружены, то генерируем начальные.
    if (currencySignals.isEmpty) {
      _handleDataUpdate();
    }

    Stream.periodic(_updatePeriod).listen((_) => _handleDataUpdate());
  }
}
