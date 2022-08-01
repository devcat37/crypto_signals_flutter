// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      title: json['title'] as String,
      shortTitle: json['shortTitle'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'title': instance.title,
      'shortTitle': instance.shortTitle,
      'image': instance.image,
    };
