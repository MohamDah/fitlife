import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/core/errors/failures.dart';

import '../../../domain/entities/gym_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/admin_repository.dart';
import '../../../domain/usecases/admin/reject_gym_usecase.dart';
import '../../datasources/remote/admin_remote_datasource.dart';

class AdminRepositoryImpl implements AdminRepository {
  AdminRepositoryImpl(this.remoteDataSource);

  final AdminRemoteDataSource remoteDataSource;

  @override
  Future<AdminStats> getAdminStats() =>
      _handleErrors(() => remoteDataSource.getAdminStats());

  @override
  Future<List<UserEntity>> getUsers({int? limit}) =>
      _handleErrors(() => remoteDataSource.getUsers(limit: limit));

  @override
  Future<List<GymEntity>> getPendingGyms() =>
      _handleErrors(() => remoteDataSource.getPendingGyms());

  @override
  Future<void> updateUserRole(String userId, String role) =>
      _handleErrors(() => remoteDataSource.updateUserRole(userId, role));

  @override
  Future<void> approveGym(String gymId, {String? notes}) =>
      _handleErrors(() => remoteDataSource.approveGym(gymId, notes: notes));

  @override
  Future<void> rejectGym(String gymId, {String? reason}) =>
      _handleErrors(() => remoteDataSource.rejectGym(gymId, reason: reason));

  Future<T> _handleErrors<T>(Future<T> Function() fn) async {
    try {
      return await fn();
    } on FirebaseException catch (e) {
      throw ServerFailure(e.message ?? 'Firestore error');
    } catch (e) {
      throw ServerFailure('Unexpected admin operation error');
    }
  }
}
