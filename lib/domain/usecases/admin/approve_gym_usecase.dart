import 'package:fitlife/core/usecases/usecase.dart';
import 'package:fitlife/core/di/injection.dart';
import '../../repositories/admin_repository.dart';

class ApproveGymParams {
  final String gymId;
  final String? notes;
  const ApproveGymParams({required this.gymId, this.notes});
}

class ApproveGymUseCase implements UseCase<void, ApproveGymParams> {
  ApproveGymUseCase(this.repository);
  final AdminRepository repository;

  @override
  Future<void> call(ApproveGymParams params) {
    return repository.approveGym(params.gymId, notes: params.notes);
  }
}
