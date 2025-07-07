import 'package:equatable/equatable.dart';

abstract class AddGoalState extends Equatable {
  const AddGoalState();

  @override
  List<Object?> get props => [];
}

class AddGoalInitial extends AddGoalState {
  const AddGoalInitial();
}

class AddGoalLoading extends AddGoalState {
  const AddGoalLoading();
}

class AddGoalSuccess extends AddGoalState {
  const AddGoalSuccess();
}

class AddGoalFailure extends AddGoalState {
  final String message;

  const AddGoalFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
