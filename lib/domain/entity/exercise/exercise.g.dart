// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      id: json['id'] as String,
      value: json['value'] as String,
      audioUrl: json['audioUrl'] as String,
      strikeCount: (json['strikeCount'] as num).toInt(),
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'audioUrl': instance.audioUrl,
      'strikeCount': instance.strikeCount,
    };
