class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false
  });

  static List<ToDo> todoList() {

    return [
      ToDo(id: '01', todoText: 'Order Biryani'),
      ToDo(id: '02', todoText: 'Work on Balance Sheet'),
      ToDo(id: '03', todoText: 'Clean plates', isDone: true),
      ToDo(id: '04', todoText: 'Exercise for 10 min', isDone: true)
    ];

  }
}