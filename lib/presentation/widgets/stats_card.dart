import 'package:flutter/material.dart';
import '../../../domain/repositories/admin_repository.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final int value;
  const StatsCard({Key? key, required this.title, required this.value})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            Text(
              value.toString(),
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
