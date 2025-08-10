import '../../../core/domain/usecase/use_case.dart';
import '../../repository/user/user_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_usecase.g.dart';

@JsonSerializable()
class RegisterParams {
  final String email;
  final String password;

  RegisterParams({required this.email, required this.password});

  factory RegisterParams.fromJson(Map<String, dynamic> json) =>
      _$RegisterParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterParamsToJson(this);
}

class RegisterUseCase implements UseCase<void, RegisterParams> {
  final UserRepository _userRepository;

  RegisterUseCase(this._userRepository);

  @override
  Future<void> call({required RegisterParams params}) async {
    return _userRepository.register(params);
  }
}
