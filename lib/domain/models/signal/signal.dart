import 'package:crypto_signals_july/domain/models/currency/currency.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signal.g.dart';

enum SignalPeriod { m_1, m_5, m_10, h_1 }
enum SignalType { up, down }

@JsonSerializable(explicitToJson: true)
class Signal {
  const Signal({
    required this.one,
    required this.two,
    required this.date,
    required this.period,
    required this.type,
    this.isPremium = false,
  });

  factory Signal.fromJson(Map<String, dynamic> json) => _$SignalFromJson(json);
  Map<String, dynamic> toJson() => _$SignalToJson(this);

  final Currency one;
  final Currency two;

  final DateTime date;
  final SignalPeriod period;
  final SignalType type;
  final bool isPremium;
}

extension SignalPeriodExt on SignalPeriod {
  String get asString {
    switch (this) {
      case SignalPeriod.m_1:
        return '01:00';
      case SignalPeriod.m_5:
        return '05:00';
      case SignalPeriod.m_10:
        return '10:00';
      case SignalPeriod.h_1:
        return '01:00:00';
    }
  }
}
