import 'package:fitlife/core/usecases/usecase.dart';
import 'package:fitlife/core/di/injection.dart';
import '../../repositories/admin_repository.dart';

class UpdateUserRoleParams {
  final String userId;
  final String role;
  const UpdateUserRoleParams({required this.userId, required this.role});
}

class UpdateUserRoleUseCase implements UseCase<void, UpdateUserRoleParams> {
  UpdateUserRoleUseCase(this.repository);
  final AdminRepository repository;

  @override
  Future<void> call(UpdateUserRoleParams params) {
    return repository.updateUserRole(params.userId, params.role);
  }
}
