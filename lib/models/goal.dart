import 'package:cloud_firestore/cloud_firestore.dart';

class Goal {
  final String id;
  final String title;
  final String description;
  final String category;
  final String status;
  final String priority;
  final DateTime? targetDate;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.priority,
    this.targetDate,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create Goal from Firestore document
  factory Goal.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Goal(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      status: data['status'] ?? '',
      priority: data['priority'] ?? '',
      targetDate: data['targetDate'] != null
          ? DateTime.parse(data['targetDate'])
          : null,
      userId: data['userId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert Goal to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'status': status,
      'priority': priority,
      'targetDate': targetDate?.toIso8601String(),
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create a copy of Goal with updated fields
  Goal copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? status,
    String? priority,
    DateTime? targetDate,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Goal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      targetDate: targetDate ?? this.targetDate,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Goal(id: $id, title: $title, status: $status, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Goal && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
