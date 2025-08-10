import 'package:json_annotation/json_annotation.dart';
import 'category_statistic.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final String id;
  final String name;
  final CategoryStatistic statistic;

  Category({
    required this.id,
    required this.name,
    required this.statistic,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
