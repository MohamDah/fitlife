import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../domain/usecases/admin/approve_gym_usecase.dart';
import '../../../domain/usecases/admin/get_admin_stats_usecase.dart';
import '../../../domain/usecases/admin/get_pending_gyms_usecase.dart';
import '../../../domain/usecases/admin/get_users_usecase.dart';
import '../../../domain/usecases/admin/reject_gym_usecase.dart';
import '../../../domain/usecases/admin/update_user_role_usecase.dart';
import 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(const AdminInitial()) {
    on<AdminDashboardLoaded>(_onLoad);
    on<UserRoleToggled>(_onToggleRole);
    on<GymApproved>(_onApproveGym);
    on<GymRejected>(_onRejectGym);
    on<RefreshDashboard>(_onRefresh);
  }

  final getStats = sl<GetAdminStatsUseCase>();
  final getUsers = sl<GetUsersUseCase>();
  final getPendingGyms = sl<GetPendingGymsUseCase>();
  final toggleRole = sl<UpdateUserRoleUseCase>();
  final approveGym = sl<ApproveGymUseCase>();
  final rejectGym = sl<RejectGymUseCase>();

  Future<void> _onLoad(
    AdminDashboardLoaded event,
    Emitter<AdminState> emit,
  ) async {
    emit(const AdminLoading());
    try {
      final stats = await getStats(const NoParams());
      final users = await getUsers(const GetUsersParams(limit: 20));
      final pending = await getPendingGyms(const NoParams());
      emit(AdminLoaded(stats: stats, users: users, pendingGyms: pending));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onToggleRole(
    UserRoleToggled event,
    Emitter<AdminState> emit,
  ) async {
    try {
      final newRole = event.isAdmin ? 'user' : 'admin';
      await toggleRole(
        UpdateUserRoleParams(userId: event.userId, role: newRole),
      );
      final newUsers = state.users
          .map((u) => u.uid == event.userId ? u.copyWith(role: newRole) : u)
          .toList();
      emit(
        AdminLoaded(
          stats: state.stats,
          users: newUsers,
          pendingGyms: state.pendingGyms,
        ),
      );
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onApproveGym(
    GymApproved event,
    Emitter<AdminState> emit,
  ) async {
    try {
      await approveGym(ApproveGymParams(gymId: event.gymId));
      final newPending = state.pendingGyms
          .where((g) => g.id != event.gymId)
          .toList();
      emit(
        AdminLoaded(
          stats: state.stats.copyWith(pendingGyms: state.stats.pendingGyms - 1),
          users: state.users,
          pendingGyms: newPending,
        ),
      );
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onRejectGym(GymRejected event, Emitter<AdminState> emit) async {
    try {
      await rejectGym(
        RejectGymParams(gymId: event.gymId, reason: event.reason),
      );
      final newPending = state.pendingGyms
          .where((g) => g.id != event.gymId)
          .toList();
      emit(
        AdminLoaded(
          stats: state.stats.copyWith(pendingGyms: state.stats.pendingGyms - 1),
          users: state.users,
          pendingGyms: newPending,
        ),
      );
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onRefresh(
    RefreshDashboard event,
    Emitter<AdminState> emit,
  ) async {
    add(const AdminDashboardLoaded());
  }
}
