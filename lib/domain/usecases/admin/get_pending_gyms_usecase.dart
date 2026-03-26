import 'package:fitlife/core/usecases/usecase.dart';
import 'package:fitlife/core/di/injection.dart';
import '../../repositories/admin_repository.dart';
import '../../../domain/entities/gym_entity.dart';

class GetPendingGymsUseCase implements UseCase<List<GymEntity>, NoParams> {
  GetPendingGymsUseCase(this.repository);
  final AdminRepository repository;

  @override
  Future<List<GymEntity>> call(NoParams params) {
    return repository.getPendingGyms();
  }
}
