import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'goals_repo.dart';
import 'models/models.dart';
import 'entities/entities.dart';

class FirebaseGoalsRepo implements GoalsRepository {
  final goalsCollection = FirebaseFirestore.instance.collection('goals');

  @override
  Stream<List<Goal>> getGoals(String userId) async* {
    // the * means can hold multiple values
    try {
      yield* goalsCollection
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Goal.fromEntity(
                  GoalEntity.fromDocument({...doc.data(), 'goalId': doc.id})))
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<Goal>> getGoalsByStatus(String userId, String status) async* {
    try {
      yield* goalsCollection
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: status)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Goal.fromEntity(
                  GoalEntity.fromDocument({...doc.data(), 'goalId': doc.id})))
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<Goal>> getGoalsByCategory(String userId, String category) async* {
    try {
      yield* goalsCollection
          .where('userId', isEqualTo: userId)
          .where('category', isEqualTo: category)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Goal.fromEntity(
                  GoalEntity.fromDocument({...doc.data(), 'goalId': doc.id})))
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Goal> getGoal(String goalId) async {
    try {
      final doc = await goalsCollection.doc(goalId).get();
      if (!doc.exists) {
        throw Exception('Goal not found');
      }
      return Goal.fromEntity(
          GoalEntity.fromDocument({...doc.data()!, 'goalId': doc.id}));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addGoal(Goal goal) async {
    try {
      final goalData = goal.toEntity().toDocument();
      goalData.remove('goalId'); // Remove goalId as Firestore will generate it
      await goalsCollection.add(goalData);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateGoal(Goal goal) async {
    try {
      final goalData = goal.toEntity().toDocument();
      goalData.remove('goalId'); // Remove goalId from data
      goalData['updatedAt'] = DateTime.now().toIso8601String();
      await goalsCollection.doc(goal.goalId).update(goalData);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteGoal(String goalId) async {
    try {
      await goalsCollection.doc(goalId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateGoalStatus(String goalId, String status) async {
    try {
      await goalsCollection.doc(goalId).update({
        'status': status,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
