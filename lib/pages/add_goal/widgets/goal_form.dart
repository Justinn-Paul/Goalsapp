import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/add_goal_bloc.dart';
import '../bloc/add_goal_event.dart';
import '../bloc/add_goal_state.dart';
import '../../../config/constants.dart';

class GoalForm extends StatefulWidget {
  const GoalForm({super.key});

  @override
  State<GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = AppConstants.goalCategories.first;
  String _selectedStatus = AppConstants.goalStatuses.first;
  String _selectedPriority = AppConstants.goalPriorities.first;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AddGoalBloc>().add(
        AddGoalSubmitted(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          category: _selectedCategory,
          status: _selectedStatus,
          priority: _selectedPriority,
          targetDate: _selectedDate,
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGoalBloc, AddGoalState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Goal Title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a goal title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: AppConstants.goalCategories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Status Dropdown
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.trending_up),
                ),
                items: AppConstants.goalStatuses.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedStatus = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Priority Dropdown
              DropdownButtonFormField<String>(
                value: _selectedPriority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.priority_high),
                ),
                items: AppConstants.goalPriorities.map((String priority) {
                  return DropdownMenuItem<String>(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPriority = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Target Date Field
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Target Date (Optional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _selectedDate == null
                        ? 'Select a target date'
                        : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: state is AddGoalLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: state is AddGoalLoading
                    ? const CircularProgressIndicator()
                    : const Text('Add Goal'),
              ),
            ],
          ),
        );
      },
    );
  }
}
