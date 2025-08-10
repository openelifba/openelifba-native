import 'package:openelifba/domain/entity/memory/update_memory_request.dart';

abstract class MemoryRepository {
  Future<void> updateMemory(UpdateMemoryRequest request);
}
