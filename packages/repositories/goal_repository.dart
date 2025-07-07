import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/goal.dart';

class GoalRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get goals for a specific user
  Stream<List<Goal>> getGoals(String userId) {
    return _firestore
        .collection('goals')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Goal.fromFirestore(doc);
          }).toList();
        });
  }

  // Get goals by status
  Stream<List<Goal>> getGoalsByStatus(String userId, String status) {
    return _firestore
        .collection('goals')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: status)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Goal.fromFirestore(doc);
          }).toList();
        });
  }

  // Add a new goal
  Future<void> addGoal(Goal goal) async {
    try {
      await _firestore.collection('goals').add({
        'title': goal.title,
        'description': goal.description,
        'category': goal.category,
        'status': goal.status,
        'priority': goal.priority,
        'targetDate': goal.targetDate?.toIso8601String(),
        'userId': goal.userId,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add goal: $e');
    }
  }

  // Update a goal
  Future<void> updateGoal(Goal goal) async {
    try {
      await _firestore.collection('goals').doc(goal.id).update({
        'title': goal.title,
        'description': goal.description,
        'category': goal.category,
        'status': goal.status,
        'priority': goal.priority,
        'targetDate': goal.targetDate?.toIso8601String(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update goal: $e');
    }
  }

  // Delete a goal
  Future<void> deleteGoal(String goalId) async {
    try {
      await _firestore.collection('goals').doc(goalId).delete();
    } catch (e) {
      throw Exception('Failed to delete goal: $e');
    }
  }

  // Get goal by ID
  Future<Goal?> getGoalById(String goalId) async {
    try {
      final doc = await _firestore.collection('goals').doc(goalId).get();
      if (doc.exists) {
        return Goal.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get goal: $e');
    }
  }

  // Update goal status
  Future<void> updateGoalStatus(String goalId, String status) async {
    try {
      await _firestore.collection('goals').doc(goalId).update({
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update goal status: $e');
    }
  }
}
