import 'package:openelifba/core/domain/usecase/use_case.dart';
import 'package:openelifba/domain/entity/memory/update_memory_request.dart';
import 'package:openelifba/domain/repository/memory/memory_repository.dart';

class UpdateMemoryUseCase extends UseCase<void, UpdateMemoryRequest> {
  final MemoryRepository _memoryRepository;

  UpdateMemoryUseCase(this._memoryRepository);

  @override
  Future<void> call({required UpdateMemoryRequest params}) async {
    return await _memoryRepository.updateMemory(params);
  }
}
