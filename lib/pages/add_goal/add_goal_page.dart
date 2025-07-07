import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/add_goal_bloc.dart';
import 'bloc/add_goal_event.dart';
import 'bloc/add_goal_state.dart';
import 'widgets/goal_form.dart';

class AddGoalPage extends StatelessWidget {
  const AddGoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddGoalBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Add New Goal'), centerTitle: true),
        body: BlocListener<AddGoalBloc, AddGoalState>(
          listener: (context, state) {
            if (state is AddGoalSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Goal added successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is AddGoalFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: GoalForm(),
          ),
        ),
      ),
    );
  }
}
