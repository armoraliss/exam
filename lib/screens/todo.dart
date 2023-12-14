class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({required this.id, required this.todoText, this.isDone = false});

  static List<Todo> todoList() {
    return [
      Todo(
          id: '01',
          todoText:
              'Morning Excercise Morning Excercise Morning Excercise Morning Excercise',
          isDone: true),
      Todo(id: '02', todoText: 'Buy google', isDone: true),
      Todo(id: '03', todoText: 'Excercise twitter', isDone: true),
      Todo(
        id: '04',
        todoText: 'Excercise youtube',
      ),
      Todo(id: '05', todoText: 'Excercise youtube, facebook', isDone: true)
    ];
  }
}
