import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/todo.dart';

class TodoItem extends StatelessWidget {

  final ToDo toDo;
  final onToDoChanged;
  final onDeleteItem;

  const TodoItem({
    Key? key,
    required this.toDo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          onTap: () {
            this.onToDoChanged(toDo);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          tileColor: Colors.white,
          leading: Icon(
            toDo.isDone ? Icons.check_box: Icons.check_box_outline_blank,
            color: MyColor().checkboxBlue,
          ),
          // leading: const Icon(Icons.check_box, color: Colors.blue),
          title: Text(
              toDo.todoText!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: toDo.isDone? TextDecoration.lineThrough : TextDecoration.none
              )
          ),
          trailing: Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5)
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: Icon(Icons.delete),
              onPressed: () {
                onDeleteItem(toDo.id);
              },
            ),
          ),
        )
    );
  }


}
