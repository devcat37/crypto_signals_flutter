// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_data_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GenerateDataState on _GenerateDataStateBase, Store {
  Computed<ObservableList<Signal>>? _$freeSignalsComputed;

  @override
  ObservableList<Signal> get freeSignals => (_$freeSignalsComputed ??=
          Computed<ObservableList<Signal>>(() => super.freeSignals,
              name: '_GenerateDataStateBase.freeSignals'))
      .value;
  Computed<ObservableList<Signal>>? _$premiumSignalsComputed;

  @override
  ObservableList<Signal> get premiumSignals => (_$premiumSignalsComputed ??=
          Computed<ObservableList<Signal>>(() => super.premiumSignals,
              name: '_GenerateDataStateBase.premiumSignals'))
      .value;

  late final _$lastUpdateAtom =
      Atom(name: '_GenerateDataStateBase.lastUpdate', context: context);

  @override
  DateTime get lastUpdate {
    _$lastUpdateAtom.reportRead();
    return super.lastUpdate;
  }

  @override
  set lastUpdate(DateTime value) {
    _$lastUpdateAtom.reportWrite(value, super.lastUpdate, () {
      super.lastUpdate = value;
    });
  }

  late final _$currencySignalsAtom =
      Atom(name: '_GenerateDataStateBase.currencySignals', context: context);

  @override
  ObservableList<Signal> get currencySignals {
    _$currencySignalsAtom.reportRead();
    return super.currencySignals;
  }

  @override
  set currencySignals(ObservableList<Signal> value) {
    _$currencySignalsAtom.reportWrite(value, super.currencySignals, () {
      super.currencySignals = value;
    });
  }

  @override
  String toString() {
    return '''
lastUpdate: ${lastUpdate},
currencySignals: ${currencySignals},
freeSignals: ${freeSignals},
premiumSignals: ${premiumSignals}
    ''';
  }
}
