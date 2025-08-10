import 'package:json_annotation/json_annotation.dart';

part 'update_memory_request.g.dart';

@JsonSerializable()
class UpdateMemoryRequest {
  @JsonKey(name: "categoryId")
  final String categoryId;

  @JsonKey(name: "exerciseId")
  final String exerciseId;

  @JsonKey(name: "success")
  final bool success;

  @JsonKey(name: "responseTimeMillis")
  final int responseTimeMillis;

  const UpdateMemoryRequest({
    required this.categoryId,
    required this.exerciseId,
    required this.success,
    required this.responseTimeMillis,
  });

  factory UpdateMemoryRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateMemoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMemoryRequestToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateMemoryRequest &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          exerciseId == other.exerciseId &&
          success == other.success &&
          responseTimeMillis == other.responseTimeMillis;

  @override
  int get hashCode =>
      categoryId.hashCode ^
      exerciseId.hashCode ^
      success.hashCode ^
      responseTimeMillis.hashCode;

  @override
  String toString() {
    return 'UpdateMemoryRequest{categoryId: $categoryId, exerciseId: $exerciseId, success: $success, responseTimeMillis: $responseTimeMillis}';
  }
}
