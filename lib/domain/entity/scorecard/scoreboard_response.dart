import 'package:json_annotation/json_annotation.dart';

import 'score_entry.dart';

part 'scoreboard_response.g.dart';

@JsonSerializable()
class ScoreboardResponse {
  final List<ScoreEntry> topScores;
  final ScoreEntry? myRank;

  const ScoreboardResponse({
    required this.topScores,
    this.myRank,
  });

  factory ScoreboardResponse.fromJson(Map<String, dynamic> json) =>
      _$ScoreboardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreboardResponseToJson(this);
}
