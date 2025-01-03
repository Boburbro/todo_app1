import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/todo_item.dart';
import '../provider/todo_provider.dart';

class ToDoItems extends StatelessWidget {
  const ToDoItems({required this.now, super.key});

  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ToDoProvider>(context);
    final dataList =
        Provider.of<ToDoProvider>(context, listen: false).list(now);
    return Expanded(
      child: dataList.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  "assets/img.png",
                  width: 200,
                ),
                const SizedBox(height: 10),
                const Text(
                  "No tasks on this day!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            )
          : ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                  value: dataList[index],
                  child: ToDoItem(
                    deleteToDo: data.deleteToDo,
                  ),
                );
              },
            ),
    );
  }
}
