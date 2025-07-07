import 'package:equatable/equatable.dart';
import '../../../models/goal.dart';

abstract class AddGoalEvent extends Equatable {
  const AddGoalEvent();

  @override
  List<Object?> get props => [];
}

class AddGoalSubmitted extends AddGoalEvent {
  final String title;
  final String description;
  final String category;
  final String status;
  final String priority;
  final DateTime? targetDate;

  const AddGoalSubmitted({
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.priority,
    this.targetDate,
  });

  @override
  List<Object?> get props => [
    title,
    description,
    category,
    status,
    priority,
    targetDate,
  ];
}

class AddGoalReset extends AddGoalEvent {
  const AddGoalReset();
}
