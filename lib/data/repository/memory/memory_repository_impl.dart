import 'package:openelifba/data/network/apis/memory/memory_api.dart';
import 'package:openelifba/domain/entity/memory/update_memory_request.dart';
import 'package:openelifba/domain/repository/memory/memory_repository.dart';

class MemoryRepositoryImpl implements MemoryRepository {
  final MemoryApi _memoryApi;

  MemoryRepositoryImpl(this._memoryApi);

  @override
  Future<void> updateMemory(UpdateMemoryRequest request) async {
    return await _memoryApi.updateMemory(request);
  }
}
