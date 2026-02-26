import 'package:json_annotation/json_annotation.dart';

part 'score_entry.g.dart';

@JsonSerializable()
class ScoreEntry {
  final String userId;
  final int score;
  final int rank;

  const ScoreEntry({
    required this.userId,
    required this.score,
    required this.rank,
  });

  factory ScoreEntry.fromJson(Map<String, dynamic> json) =>
      _$ScoreEntryFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreEntryToJson(this);
}
