// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_memory_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMemoryRequest _$UpdateMemoryRequestFromJson(Map<String, dynamic> json) =>
    UpdateMemoryRequest(
      categoryId: json['categoryId'] as String,
      exerciseId: json['exerciseId'] as String,
      success: json['success'] as bool,
      responseTimeMillis: (json['responseTimeMillis'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateMemoryRequestToJson(
        UpdateMemoryRequest instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'exerciseId': instance.exerciseId,
      'success': instance.success,
      'responseTimeMillis': instance.responseTimeMillis,
    };
