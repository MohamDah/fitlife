import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/gym_model.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/entities/gym_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/admin_repository.dart';

class AdminRemoteDataSource {
  AdminRemoteDataSource(this.firestore);
  final FirebaseFirestore firestore;

  Future<AdminStats> getAdminStats() async {
    // Total users
    final usersSnap = await firestore.collection('users').get();
    final totalUsers = usersSnap.size;

    // Total gyms
    final gymsSnap = await firestore.collection('gyms').get();
    final totalGyms = gymsSnap.size;

    // Pending gyms count
    final pendingSnap = await firestore
        .collection('gyms')
        .where('status', isEqualTo: 'pending')
        .get();
    final pendingGyms = pendingSnap.size;

    // Admins count
    final adminsSnap = await firestore
        .collection('users')
        .where('role', isEqualTo: 'admin')
        .get();
    final admins = adminsSnap.size;

    return AdminStats(
      totalUsers: totalUsers,
      totalGyms: totalGyms,
      pendingGyms: pendingGyms,
      admins: admins,
    );
  }

  Future<List<UserEntity>> getUsers({int? limit}) async {
    final query = firestore
        .collection('users')
        .limit(limit ?? 50)
        .orderBy('createdAt', descending: true);
    final snap = await query.get();
    return snap.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
  }

  Future<List<GymEntity>> getPendingGyms() async {
    final query = firestore
        .collection('gyms')
        .where('status', isEqualTo: 'pending');
    final snap = await query.get();
    return snap.docs
        .map((doc) => GymModel.fromFirestore(snapshot: doc))
        .toList();
  }

  Future<void> updateUserRole(String userId, String role) async {
    await firestore.collection('users').doc(userId).update({'role': role});
  }

  Future<void> approveGym(String gymId, {String? notes}) async {
    final data = <String, dynamic>{'status': 'approved'};
    if (notes != null) data['adminNotes'] = notes;
    await firestore.collection('gyms').doc(gymId).update(data);
  }

  Future<void> rejectGym(String gymId, {String? reason}) async {
    final data = <String, dynamic>{'status': 'rejected'};
    if (reason != null) data['rejectReason'] = reason;
    await firestore.collection('gyms').doc(gymId).update(data);
  }
}
