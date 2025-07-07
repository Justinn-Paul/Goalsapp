import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadGoals extends HomeEvent {
  const LoadGoals();
}

class FilterGoalsByCategory extends HomeEvent {
  final String category;

  const FilterGoalsByCategory({required this.category});

  @override
  List<Object?> get props => [category];
}

class FilterGoalsByStatus extends HomeEvent {
  final String status;

  const FilterGoalsByStatus({required this.status});

  @override
  List<Object?> get props => [status];
}

class ClearFilters extends HomeEvent {
  const ClearFilters();
}
