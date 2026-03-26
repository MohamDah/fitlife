import 'package:fitlife/core/usecases/usecase.dart';
import 'package:fitlife/core/di/injection.dart';
import '../../repositories/admin_repository.dart';

class RejectGymParams {
  final String gymId;
  final String? reason;
  const RejectGymParams({required this.gymId, this.reason});
}

class RejectGymUseCase implements UseCase<void, RejectGymParams> {
  RejectGymUseCase(this.repository);
  final AdminRepository repository;

  @override
  Future<void> call(RejectGymParams params) {
    return repository.rejectGym(params.gymId, reason: params.reason);
  }
}
