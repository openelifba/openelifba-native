import '../../../core/domain/usecase/use_case.dart';
import '../../entity/user/user.dart';
import '../../repository/user/user_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_login_in_status_usecase.g.dart';

@JsonSerializable()
class SaveLoginStatusParams {
  final bool isLoggedIn;
  final User? user;

  SaveLoginStatusParams({required this.isLoggedIn, this.user});

  factory SaveLoginStatusParams.fromJson(Map<String, dynamic> json) =>
      _$SaveLoginStatusParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SaveLoginStatusParamsToJson(this);
}

class SaveLoginStatusUseCase implements UseCase<void, SaveLoginStatusParams> {
  final UserRepository _userRepository;

  SaveLoginStatusUseCase(this._userRepository);

  @override
  Future<void> call({required SaveLoginStatusParams params}) async {
    return _userRepository.saveIsLoggedIn(params);
  }
}
