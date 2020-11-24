class Task {
  String title;
  bool isDone;
  String category;

  Task({this.title, this.isDone = false, this.category});

  void toggleIsDone() {
    isDone = !isDone;
  }

  Task.fromMap(Map snapshot, String id)
      : title = snapshot['title'] ?? '',
        isDone = snapshot['isDone'] ?? false,
        category = snapshot['category'] ?? '';

  toJson() {
    return {"title": title, "isDone": isDone, "category": category};
  }
}
