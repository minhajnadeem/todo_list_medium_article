/// Simple Todo model for our demo app.
/// Each task has: id, title, and two flags (isDone, isFavorite).
class Todo {
  final String id;
  final String title;
  final bool isDone;
  final bool isFavorite;

  const Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    this.isFavorite = false,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? isDone,
    bool? isFavorite,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
