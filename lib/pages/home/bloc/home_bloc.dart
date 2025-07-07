import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../packages/repositories/goal_repository.dart';
import '../../../models/goal.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GoalRepository _goalRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  HomeBloc({GoalRepository? goalRepository})
    : _goalRepository = goalRepository ?? GoalRepository(),
      super(const HomeInitial()) {
    on<LoadGoals>(_onLoadGoals);
    on<FilterGoalsByCategory>(_onFilterGoalsByCategory);
    on<FilterGoalsByStatus>(_onFilterGoalsByStatus);
    on<ClearFilters>(_onClearFilters);
  }

  Future<void> _onLoadGoals(LoadGoals event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final goalsStream = _goalRepository.getGoals(user.uid);
        await emit.onEach<List<Goal>>(
          goalsStream,
          onData: (goals) => emit(HomeLoaded(goals: goals)),
        );
      } else {
        emit(const HomeLoaded(goals: []));
      }
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onFilterGoalsByCategory(
    FilterGoalsByCategory event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final user = _auth.currentUser;
      if (user != null) {
        try {
          // For now, we'll filter client-side
          // In a real app, you might want to filter on the server
          final allGoals = await _goalRepository.getGoals(user.uid).first;
          final filteredGoals = allGoals
              .where((goal) => goal.category == event.category)
              .toList();

          emit(
            HomeLoaded(
              goals: filteredGoals,
              selectedCategory: event.category,
              selectedStatus: currentState.selectedStatus,
            ),
          );
        } catch (e) {
          emit(HomeError(message: e.toString()));
        }
      }
    }
  }

  Future<void> _onFilterGoalsByStatus(
    FilterGoalsByStatus event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final user = _auth.currentUser;
      if (user != null) {
        try {
          final allGoals = await _goalRepository.getGoals(user.uid).first;
          final filteredGoals = allGoals
              .where((goal) => goal.status == event.status)
              .toList();

          emit(
            HomeLoaded(
              goals: filteredGoals,
              selectedCategory: currentState.selectedCategory,
              selectedStatus: event.status,
            ),
          );
        } catch (e) {
          emit(HomeError(message: e.toString()));
        }
      }
    }
  }

  Future<void> _onClearFilters(
    ClearFilters event,
    Emitter<HomeState> emit,
  ) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final goals = await _goalRepository.getGoals(user.uid).first;
        emit(HomeLoaded(goals: goals));
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    }
  }
}
