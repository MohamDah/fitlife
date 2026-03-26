# Admin Dashboard Implementation TODO

Current branch: admin

## Steps (approved plan):

1. [x] Update lib/domain/entities/gym_entity.dart (add status field)
2. [x] Update lib/data/models/gym_model.dart (mirror status)
3. [x] Create lib/domain/repositories/admin_repository.dart
4. [x] Create lib/domain/usecases/admin/ directory and usecases: GetAdminStatsUseCase, GetUsersUseCase, GetPendingGymsUseCase, UpdateUserRoleUseCase, ApproveGymUseCase
5. [x] Create lib/data/datasources/remote/admin_remote_datasource.dart
6. [x] Create lib/data/repositories/admin_repository_impl.dart
7. [x] Register in lib/core/di/injection.dart: AdminRepository, usecases, AdminBloc
8. [ ] Create lib/presentation/blocs/admin/admin_bloc.dart (events/states for dashboard)
9. [ ] Create widgets: lib/presentation/widgets/admin_user_tile.dart, admin_gym_approval_card.dart, stats_cards.dart
10. [ ] Implement lib/presentation/pages/admin/admin_dashboard_page.dart (full UI: stats, tabs for users/gyms)
11. [ ] Update lib/presentation/pages/admin/gym_form_page.dart if needed for status
12. [ ] `flutter pub get &amp;&amp; flutter run -d chrome`
13. [ ] Test: Create admin user in Firestore, login, verify /admin
14. [ ] git commit &amp;&amp; git push origin admin

Progress tracked here after each step.
