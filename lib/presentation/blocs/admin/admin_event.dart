part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
  @override
  List<Object?> get props => [];
}

class AdminDashboardLoaded extends AdminEvent {}

class UserRoleToggled extends AdminEvent {
  final String userId;
  final bool isAdmin;
  const UserRoleToggled(this.userId, this.isAdmin);
  @override
  List<Object?> get props => [userId, isAdmin];
}

class GymApproved extends AdminEvent {
  final String gymId;
  const GymApproved(this.gymId);
  @override
  List<Object?> get props => [gymId];
}

class GymRejected extends AdminEvent {
  final String gymId;
  final String? reason;
  const GymRejected(this.gymId, {this.reason});
  @override
  List<Object?> get props => [gymId, reason];
}

class RefreshDashboard extends AdminEvent {}
