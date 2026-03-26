import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/gym_entity.dart';
import '../blocs/admin/admin_bloc.dart';
import '../blocs/admin/admin_event.dart';
import 'gym_card.dart';

class AdminGymApprovalCard extends StatelessWidget {
  final GymEntity gym;
  const AdminGymApprovalCard({Key? key, required this.gym}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GymCard(gym: gym, isSaved: false, onTap: () {}, onSaveToggle: (_) {}),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                icon: Icon(Icons.thumb_down),
                label: Text('Reject'),
                onPressed: () => _showRejectDialog(context),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.thumb_up),
                label: Text('Approve'),
                onPressed: () =>
                    context.read<AdminBloc>().add(GymApproved(gym.id)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Reject ${gym.name}'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Reason'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AdminBloc>().add(
                GymRejected(gym.id, controller.text),
              );
            },
            child: Text('Reject'),
          ),
        ],
      ),
    );
  }
}
