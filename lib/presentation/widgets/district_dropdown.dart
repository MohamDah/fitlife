import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';

/// A dropdown that lets the user filter the gym feed by Kigali district.
/// Emits the selected district via [onChanged]; passing null selects
/// "All Districts".
///
/// Fully [StatelessWidget] — parent owns the selected state via BLoC.
class DistrictDropdown extends StatelessWidget {
  const DistrictDropdown({
    super.key,
    required this.selectedDistrict,
    required this.onChanged,
  });

  final String? selectedDistrict;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = [
      DropdownMenuItem<String>(
        value: null,
        child: Text(AppStrings.allDistricts, style: theme.textTheme.bodyMedium),
      ),
      ...AppConstants.districts.map(
        (d) => DropdownMenuItem<String>(
          value: d,
          child: Text(d, style: theme.textTheme.bodyMedium),
        ),
      ),
    ];

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        key: const Key('district_dropdown'),
        value: selectedDistrict,
        items: items,
        onChanged: onChanged,
        icon: const Icon(Icons.arrow_drop_down, size: 20),
        style: theme.textTheme.bodyMedium,
        borderRadius: BorderRadius.circular(12),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
