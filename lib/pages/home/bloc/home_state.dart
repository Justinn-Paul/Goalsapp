import 'package:equatable/equatable.dart';
import '../../../models/goal.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Goal> goals;
  final String? selectedCategory;
  final String? selectedStatus;

  const HomeLoaded({
    required this.goals,
    this.selectedCategory,
    this.selectedStatus,
  });

  @override
  List<Object?> get props => [goals, selectedCategory, selectedStatus];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
