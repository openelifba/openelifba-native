import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

@JsonSerializable()
class Exercise {
  @JsonKey(name: "id")
  final String id;

  @JsonKey(name: "value")
  final String value;

  @JsonKey(name: "audioUrl")
  final String audioUrl;

  const Exercise({
    required this.id,
    required this.value,
    required this.audioUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Exercise &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          value == other.value &&
          audioUrl == other.audioUrl;

  @override
  int get hashCode => id.hashCode ^ value.hashCode ^ audioUrl.hashCode;

  @override
  String toString() {
    return 'Exercise{id: $id, value: $value, audioUrl: $audioUrl}';
  }
}
