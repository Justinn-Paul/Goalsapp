import '../entities/entities.dart';

class Goal {
  String goalId;
  String title;
  String description;
  String category;
  String status;
  String priority;
  String userId;
  DateTime? targetDate;
  DateTime createdAt;
  DateTime updatedAt;

  Goal({
    required this.goalId,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.priority,
    required this.userId,
    this.targetDate,
    required this.createdAt,
    required this.updatedAt,
  });

  static final empty = Goal(
    goalId: '',
    title: '',
    description: '',
    category: '',
    status: '',
    priority: '',
    userId: '',
    targetDate: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  GoalEntity toEntity() {
    return GoalEntity(
      goalId: goalId,
      title: title,
      description: description,
      category: category,
      status: status,
      priority: priority,
      userId: userId,
      targetDate: targetDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static Goal fromEntity(GoalEntity entity) {
    return Goal(
      goalId: entity.goalId,
      title: entity.title,
      description: entity.description,
      category: entity.category,
      status: entity.status,
      priority: entity.priority,
      userId: entity.userId,
      targetDate: entity.targetDate,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Goal: $goalId, $title, $category, $status';
  }
}
