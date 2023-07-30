import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_item.dart';
import '../constants/colors.dart';

class HomePage extends StatefulWidget {

  HomePage({Key? key}): super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColor().background,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                _searchBox(),
                Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          child: const Text(
                            'All ToDos',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),

                        for ( ToDo todo in _foundToDo )
                          TodoItem(
                              toDo : todo,
                              onToDoChanged: _handleToDoChange,
                              onDeleteItem: _deleteTodoItem,
                          )
                      ],
                    )
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        left: 20
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: MyColor().white,
                        boxShadow: const [BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0
                        )],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: const InputDecoration(
                          hintText: 'Add a new Todo item',
                          border: InputBorder.none
                        ),
                      ),
                    )
                ),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addTodoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: MyColor().white,
                      backgroundColor: MyColor().checkboxBlue,
                      minimumSize: const Size(60, 60),
                      elevation: 10
                    ),
                    child: const Text(
                        '+',
                        style: TextStyle(
                            fontSize: 40
                        )
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todoList.removeWhere((todoItem) => todoItem.id == id);
    });
  }

  void _addTodoItem(String value) {
    setState(() {
      todoList.add(
          ToDo(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              todoText: value
          )
      );
    });
    _todoController.clear();
  }

  void searchFilter(String searchText) {
    List<ToDo> results = [];
    if(searchText.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((todoItem) => todoItem.todoText!
          .toLowerCase()
          .contains(searchText.toLowerCase())
      ).toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget _searchBox() {
    return Container(
      decoration: BoxDecoration(
          color: MyColor().white,
          borderRadius: BorderRadius.circular(25)
      ),
      child: TextField(
        onChanged: (value) => searchFilter(value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            border: InputBorder.none,
            hintText: "Search a Task"
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: MyColor().background,
      title: Text("Hello Devru"),
    );
  }
}
