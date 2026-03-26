import 'package:fitlife/core/usecases/usecase.dart';
import 'package:fitlife/core/di/injection.dart';
import '../../repositories/admin_repository.dart';

class GetAdminStatsUseCase implements UseCase<AdminStats, NoParams> {
  GetAdminStatsUseCase(this.repository);
  final AdminRepository repository;

  @override
  Future<AdminStats> call(NoParams params) {
    return repository.getAdminStats();
  }
}
