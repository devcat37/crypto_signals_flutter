import 'package:crypto_signals_july/domain/models/signal/signal.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signals_data.g.dart';

@JsonSerializable(explicitToJson: true)
class SignalsData {
  const SignalsData({
    required this.currencySignals,
    required this.lastUpdate,
  });

  factory SignalsData.fromJson(Map<String, dynamic> json) => _$SignalsDataFromJson(json);
  Map<String, dynamic> toJson() => _$SignalsDataToJson(this);

  final List<Signal> currencySignals;

  final DateTime lastUpdate;
}
