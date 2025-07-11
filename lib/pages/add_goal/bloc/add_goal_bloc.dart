import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goals_repository/goals_repository.dart';
import 'add_goal_event.dart';
import 'add_goal_state.dart';

class AddGoalBloc extends Bloc<AddGoalEvent, AddGoalState> {
  final FirebaseGoalsRepo _goalRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AddGoalBloc({FirebaseGoalsRepo? goalRepository})
    : _goalRepository = goalRepository ?? FirebaseGoalsRepo(),
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
        goalId: '', // Will be set by Firestore
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
