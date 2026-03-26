part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();
  @override
  List<Object?> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {
  final AdminStats stats;
  final List<UserEntity> users;
  final List<GymEntity> pendingGyms;
  const AdminLoaded({
    required this.stats,
    this.users = const [],
    this.pendingGyms = const [],
  });
  @override
  List<Object?> get props => [stats, users, pendingGyms];

  AdminLoaded copyWith({
    AdminStats? stats,
    List<UserEntity>? users,
    List<GymEntity>? pendingGyms,
  }) {
    return AdminLoaded(
      stats: stats ?? this.stats,
      users: users ?? this.users,
      pendingGyms: pendingGyms ?? this.pendingGyms,
    );
  }
}

class AdminError extends AdminState {
  final String message;
  const AdminError(this.message);
  @override
  List<Object?> get props => [message];
}
