import 'package:flutter/material.dart';
import '../config/constants.dart';

class StatusDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;
  final String label;

  const StatusDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Status',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.trending_up),
      ),
      items: AppConstants.goalStatuses.map((String status) {
        return DropdownMenuItem<String>(value: status, child: Text(status));
      }).toList(),
      onChanged: onChanged,
    );
  }
}
