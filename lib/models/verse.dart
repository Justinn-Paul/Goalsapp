class Verse {
  final String id;
  final String text;
  final String author;
  final String category;

  Verse({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
  });

  // Create Verse from JSON
  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? '',
    );
  }

  // Convert Verse to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text, 'author': author, 'category': category};
  }

  @override
  String toString() {
    return 'Verse(id: $id, text: $text, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Verse && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
