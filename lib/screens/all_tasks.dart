import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../provider/todo_provider.dart';
import 'add_todo_item.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ToDoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("All tasks"),
        centerTitle: true,
      ),
      drawer: const AppDrawer(onScreen: 'all-tasks'),
      body: data.allList.isEmpty
          ? Center(
              child: Column(
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
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.allList.length,
              itemBuilder: (ctx, index) {
                final subData = data.allList[index];
                return Card(
                  child: ListTile(
                    title: Text(subData.title),
                    subtitle:
                        Text(DateFormat("EEEE, dd.MM.y").format(subData.date)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  content: const Text(
                                    "Would you like to delete it?",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      child: const Text("CANCEL"),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          data.deleteToDo(subData.rId);
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text("Ha"))
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              isDismissible: false,
                              context: context,
                              builder: (ctx) {
                                return AddToDoItem(
                                  id: subData.rId,
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.edit_rounded),
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
