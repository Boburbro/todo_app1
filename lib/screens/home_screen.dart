import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_todo_item.dart';

import '../provider/todo_provider.dart';
import '../widgets/home_appBar.dart';
import '../widgets/todo_items.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime now = DateTime.now();
  var isLoading = true;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    Provider.of<ToDoProvider>(context, listen: false)
        .getAllData()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  void openPicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    ).then((date) {
      setState(() {
        now = date!;
      });
    });
  }

  void addOneDay() {
    setState(() {
      now = DateTime(now.year, now.month, now.day + 1);
    });
  }

  void minusOneDay() {
    setState(() {
      now = DateTime(now.year, now.month, now.day - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do app"),
      ),
      drawer: const Drawer(),
      body: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(
                color: CupertinoColors.activeBlue,
                radius: 20,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  HomeAppBar(
                    openPicker: openPicker,
                    now: now,
                    addDay: addOneDay,
                    minusDay: minusOneDay,
                  ),
                  ToDoItems(
                    now: now,
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            builder: (ctx) {
              return const AddToDoItem();
            },
          );
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
