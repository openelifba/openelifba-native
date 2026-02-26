// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreEntry _$ScoreEntryFromJson(Map<String, dynamic> json) => ScoreEntry(
      userId: json['userId'] as String,
      score: (json['score'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
    );

Map<String, dynamic> _$ScoreEntryToJson(ScoreEntry instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'score': instance.score,
      'rank': instance.rank,
    };
