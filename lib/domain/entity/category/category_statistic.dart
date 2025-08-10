import 'package:json_annotation/json_annotation.dart';

part 'category_statistic.g.dart';

@JsonSerializable()
class CategoryStatistic {
  final int totalExerciseCount;
  final int reviewedExerciseCount;
  final int dueExerciseCount;
  final double averageSpeedSec;
  final double accuracyPercent;
  final String status;

  CategoryStatistic({
    required this.totalExerciseCount,
    required this.reviewedExerciseCount,
    required this.dueExerciseCount,
    required this.averageSpeedSec,
    required this.accuracyPercent,
    required this.status,
  });

  factory CategoryStatistic.fromJson(Map<String, dynamic> json) =>
      _$CategoryStatisticFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryStatisticToJson(this);
}
