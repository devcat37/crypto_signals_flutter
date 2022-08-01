// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Signal _$SignalFromJson(Map<String, dynamic> json) => Signal(
      one: Currency.fromJson(json['one'] as Map<String, dynamic>),
      two: Currency.fromJson(json['two'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      period: $enumDecode(_$SignalPeriodEnumMap, json['period']),
      type: $enumDecode(_$SignalTypeEnumMap, json['type']),
      isPremium: json['isPremium'] as bool? ?? false,
    );

Map<String, dynamic> _$SignalToJson(Signal instance) => <String, dynamic>{
      'one': instance.one.toJson(),
      'two': instance.two.toJson(),
      'date': instance.date.toIso8601String(),
      'period': _$SignalPeriodEnumMap[instance.period]!,
      'type': _$SignalTypeEnumMap[instance.type]!,
      'isPremium': instance.isPremium,
    };

const _$SignalPeriodEnumMap = {
  SignalPeriod.m_1: 'm_1',
  SignalPeriod.m_5: 'm_5',
  SignalPeriod.m_10: 'm_10',
  SignalPeriod.h_1: 'h_1',
};

const _$SignalTypeEnumMap = {
  SignalType.up: 'up',
  SignalType.down: 'down',
};
