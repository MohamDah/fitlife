import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../blocs/admin/admin_bloc.dart';
import '../blocs/admin/admin_event.dart';

class AdminUserTile extends StatelessWidget {
  final UserEntity user;
  const AdminUserTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(user.email[0].toUpperCase())),
      title: Text(user.email),
      subtitle: Text('ID: ${user.uid}'),
      trailing: Switch(
        value: user.isAdmin,
        onChanged: (value) =>
            context.read<AdminBloc>().add(UserRoleToggled(user.uid, value)),
      ),
    );
  }
}
