class Post {
  final int id;
  final String title;
  final String textBody;
  final String authorName;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    required this.textBody,
    required this.authorName,
    required this.createdAt,
  });

  Post copyWith({
    int? id,
    String? title,
    String? textBody,
    String? authorName,
    DateTime? createdAt,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      textBody: textBody ?? this.textBody,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
