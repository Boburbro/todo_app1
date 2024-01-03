import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({required this.deleteToDo, super.key});

  final Function deleteToDo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<ToDo>(
        builder: (ctx, todoData, _) => ListTile(
          leading: IconButton(
            onPressed: () => todoData.changeIsDone(),
            icon: Icon(
              todoData.isDone
                  ? Icons.check_circle_outline_rounded
                  : Icons.circle_outlined,
              color: todoData.isDone ? Colors.green : Colors.grey,
            ),
          ),
          title: Text(
            todoData.title,
            style: todoData.isDone
                ? const TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey)
                : TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
          ),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      content: const Text(
                        "Bu vazifani o'chirmoqchimisiz?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text("BEKOR QILISH"),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              deleteToDo(todoData.rId);
                              Navigator.of(ctx).pop();
                            },
                            child: const Text("Ha"))
                      ],
                    );
                  });
            }, // => ,
            icon: const Icon(
              Icons.delete_forever_rounded,
            ),
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
