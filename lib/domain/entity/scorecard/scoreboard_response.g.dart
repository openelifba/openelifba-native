// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scoreboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreboardResponse _$ScoreboardResponseFromJson(Map<String, dynamic> json) =>
    ScoreboardResponse(
      topScores: (json['topScores'] as List<dynamic>)
          .map((e) => ScoreEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      myRank: json['myRank'] == null
          ? null
          : ScoreEntry.fromJson(json['myRank'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScoreboardResponseToJson(
        ScoreboardResponse instance) =>
    <String, dynamic>{
      'topScores': instance.topScores,
      'myRank': instance.myRank,
    };
