import 'models/models.dart';

abstract class GoalsRepository {
  Stream<List<Goal>> getGoals(String userId);

  Stream<List<Goal>> getGoalsByStatus(String userId, String status);

  Stream<List<Goal>> getGoalsByCategory(
      String userId, String category); // filtering logic

  Future<Goal> getGoal(String goalId);

  Future<void> addGoal(Goal goal);

  Future<void> updateGoal(Goal goal);

  Future<void> deleteGoal(String goalId);

  Future<void> updateGoalStatus(String goalId, String status);
}
