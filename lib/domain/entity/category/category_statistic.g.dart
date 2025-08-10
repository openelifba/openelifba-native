// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_statistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryStatistic _$CategoryStatisticFromJson(Map<String, dynamic> json) =>
    CategoryStatistic(
      totalExerciseCount: (json['totalExerciseCount'] as num).toInt(),
      reviewedExerciseCount: (json['reviewedExerciseCount'] as num).toInt(),
      dueExerciseCount: (json['dueExerciseCount'] as num).toInt(),
      averageSpeedSec: (json['averageSpeedSec'] as num).toDouble(),
      accuracyPercent: (json['accuracyPercent'] as num).toDouble(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$CategoryStatisticToJson(CategoryStatistic instance) =>
    <String, dynamic>{
      'totalExerciseCount': instance.totalExerciseCount,
      'reviewedExerciseCount': instance.reviewedExerciseCount,
      'dueExerciseCount': instance.dueExerciseCount,
      'averageSpeedSec': instance.averageSpeedSec,
      'accuracyPercent': instance.accuracyPercent,
      'status': instance.status,
    };
