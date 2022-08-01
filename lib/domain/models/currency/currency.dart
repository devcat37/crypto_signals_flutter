import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

@JsonSerializable(explicitToJson: true)
class Currency {
  const Currency({
    required this.title,
    required this.shortTitle,
    required this.image,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);

  final String title;
  final String shortTitle;
  final String image;
}
