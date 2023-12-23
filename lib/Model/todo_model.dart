class TodoCategory {
  String? uid;

  String title;

  String emoji;

  // bool isCompleted;

  // List<Todo> todoList;

  TodoCategory({required this.title, this.uid, required this.emoji});

  factory TodoCategory.fromJosn(Map<String, dynamic> categoryData) {
    return TodoCategory(uid: categoryData['uid'], title: categoryData['title'], emoji: categoryData['emoji']);
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
  String? uid;
  String title;
  bool isCompleted;
  int timestamp;

  Todo({required this.title, required this.isCompleted, required this.timestamp, this.uid});

  factory Todo.fromJson(Map<String, dynamic> todoList) {
    return Todo(
      isCompleted: todoList['isCompleted'],
      title: todoList['title'],
      timestamp: todoList['timestamp'],
      uid: todoList['uid']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid ?? '',
      'title': title,
      'isCompleted': isCompleted,
      'timestamp': timestamp,
    };
  }
}
