import '../../../core/domain/usecase/use_case.dart';
import '../../repository/user/user_repository.dart';

class GetUserIdUseCase extends UseCase<String?, void> {
  final UserRepository _userRepository;

  GetUserIdUseCase(this._userRepository);

  @override
  Future<String?> call({required void params}) async {
    return _userRepository.userId;
  }
}
