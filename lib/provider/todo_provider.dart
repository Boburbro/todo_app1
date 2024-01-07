import 'package:flutter/material.dart';
import 'package:todo_app/provider/sql_helper.dart';

import '../models/todo.dart';

class ToDoProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<ToDo> _list = [];

  List<ToDo> list(DateTime time) {
    return _list
        .where(
          (todo) =>
              todo.date.day == time.day &&
              todo.date.month == time.month &&
              todo.date.year == time.year,
        )
        .toList();
  }

  List<ToDo> doneList(DateTime time) {
    return list(time).where((todo) => todo.isDone == true).toList();
  }

  List<String> itemsLength(DateTime time) {
    return [list(time).length.toString(), doneList(time).length.toString()];
  }

  Future<void> getAllData() async {
    final data = await SqlHelper.getItems();
    if (data.isNotEmpty) {
      for (var element in data) {
        _list.add(
          ToDo(
            rId: element['id'],
            title: element["title"],
            date: DateTime.parse(element['date']),
            isDone: bool.parse(element['isDone']),
          ),
        );
      }
    }
    notifyListeners();
  }

  Future<void> deleteToDo(String id) async {
    try {
      await SqlHelper.deleteItem(id);
      _list.removeWhere((element) => element.rId == id);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> addNewToDo(String title, DateTime time) async {
    final String id = UniqueKey().toString();
    await SqlHelper.createItem(id, title, time.toIso8601String(), 'false')
        .then((value) {
      _list.add(ToDo(rId: id, title: title, date: time));
    });

    notifyListeners();
  }
}
