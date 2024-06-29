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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone ? 1 : 0,
      'createdOn': createdOn.toIso8601String(),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'] == 1,
      createdOn: DateTime.parse(map['createdOn']),
    );
  }
}
