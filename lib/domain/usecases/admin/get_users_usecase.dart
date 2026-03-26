import 'package:fitlife/core/usecases/usecase.dart';
import 'package:fitlife/core/di/injection.dart';
import '../../repositories/admin_repository.dart';
import '../../../domain/entities/user_entity.dart';

class GetUsersParams {
  final int? limit;
  const GetUsersParams({this.limit});
}

class GetUsersUseCase implements UseCase<List<UserEntity>, GetUsersParams> {
  GetUsersUseCase(this.repository);
  final AdminRepository repository;

  @override
  Future<List<UserEntity>> call(GetUsersParams params) {
    return repository.getUsers(limit: params.limit);
  }
}
