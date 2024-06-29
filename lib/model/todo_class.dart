class Todo {
  int id;
  String title;
  String description;
  bool isDone;
  DateTime createdOn;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    required this.createdOn,
  });

  Todo copyWith({
    String? title,
    String? description,
    int? id,
    DateTime? createdOn,
    bool? isDone,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      createdOn: createdOn ?? this.createdOn,
      isDone: isDone ?? this.isDone,
    );
  }
}
