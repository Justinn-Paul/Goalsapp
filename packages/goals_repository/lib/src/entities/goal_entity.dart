class GoalEntity {
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

  GoalEntity({
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

  Map<String, Object?> toDocument() {
    return {
      'goalId': goalId,
      'title': title,
      'description': description,
      'category': category,
      'status': status,
      'priority': priority,
      'userId': userId,
      'targetDate': targetDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static GoalEntity fromDocument(Map<String, dynamic> doc) {
    return GoalEntity(
      goalId: doc['goalId'] ?? '',
      title: doc['title'] ?? '',
      description: doc['description'] ?? '',
      category: doc['category'] ?? '',
      status: doc['status'] ?? '',
      priority: doc['priority'] ?? '',
      userId: doc['userId'] ?? '',
      targetDate:
          doc['targetDate'] != null ? DateTime.parse(doc['targetDate']) : null,
      createdAt: DateTime.parse(doc['createdAt']),
      updatedAt: DateTime.parse(doc['updatedAt']),
    );
  }
}
