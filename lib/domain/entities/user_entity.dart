import 'package:equatable/equatable.dart';

/// Domain-level user entity. Implemented by Person 2 (Auth).
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.displayName,
    required this.role,
    this.photoUrl,
    this.savedGymIds = const [],
  });

  final String id;
  final String email;
  final String displayName;
  final String role; // 'user' | 'admin'
  final String? photoUrl;
  final List<String> savedGymIds;

  bool get isAdmin => role == 'admin';

  @override
  List<Object?> get props =>
      [id, email, displayName, role, photoUrl, savedGymIds];
}
