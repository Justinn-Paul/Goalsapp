import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../packages/repositories/goal_repository.dart';
import '../../../models/goal.dart';
import 'add_goal_event.dart';
import 'add_goal_state.dart';

class AddGoalBloc extends Bloc<AddGoalEvent, AddGoalState> {
  final GoalRepository _goalRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AddGoalBloc({GoalRepository? goalRepository})
    : _goalRepository = goalRepository ?? GoalRepository(),
      super(const AddGoalInitial()) {
    on<AddGoalSubmitted>(_onAddGoalSubmitted);
    on<AddGoalReset>(_onAddGoalReset);
  }

  Future<void> _onAddGoalSubmitted(
    AddGoalSubmitted event,
    Emitter<AddGoalState> emit,
  ) async {
    emit(const AddGoalLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(const AddGoalFailure(message: 'User not authenticated'));
        return;
      }

      final goal = Goal(
        id: '', // Will be set by Firestore
        title: event.title,
        description: event.description,
        category: event.category,
        status: event.status,
        priority: event.priority,
        targetDate: event.targetDate,
        userId: user.uid,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _goalRepository.addGoal(goal);
      emit(const AddGoalSuccess());
    } catch (e) {
      emit(AddGoalFailure(message: e.toString()));
    }
  }

  Future<void> _onAddGoalReset(
    AddGoalReset event,
    Emitter<AddGoalState> emit,
  ) async {
    emit(const AddGoalInitial());
  }
}
