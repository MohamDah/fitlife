import '../../core/errors/failures.dart';
import '../entities/gym_entity.dart';
import '../entities/user_entity.dart';

abstract class AdminRepository {
  Future<AdminStats> getAdminStats();
  Future<List<UserEntity>> getUsers({int? limit});
  Future<List<GymEntity>> getPendingGyms();
  Future<void> updateUserRole(String userId, String role);
  Future<void> approveGym(String gymId, {String? notes});
  Future<void> rejectGym(String gymId, {String? reason});
}

class AdminStats {
  final int totalUsers;
  final int totalGyms;
  final int pendingGyms;
  final int admins;

  const AdminStats({
    required this.totalUsers,
    required this.totalGyms,
    required this.pendingGyms,
    required this.admins,
  });
}
