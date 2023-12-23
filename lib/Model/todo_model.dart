class TodoCategory {
  String? uid;

  String title;

  String emoji;

  // bool isCompleted;

  // List<Todo> todoList;

  TodoCategory({
    required this.title,
    this.uid,
    required this.emoji
  });

  factory TodoCategory.fromJosn(Map<String, dynamic> categoryData) {
    return TodoCategory(
      uid: categoryData['uid'],
      title: categoryData['title'],
      emoji: categoryData['emoji']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid ?? '000',
      'title': title,
      'emoji': emoji,
    };
  }
}

class Todo {
  String title;
  bool isCompleted;
  int timestamp;

  Todo({
    required this.title,
    required this.isCompleted,
    required this.timestamp,
  });

  // factory Todo.fromJson(Map<String, dynamic> todoList) {
  //   return Todo(
  //     title: title,
  //     isCompleted: isCompleted,
  //     categoryId: categoryId,
  //   );
  // }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'timestamp': timestamp,
    };
  }
}
