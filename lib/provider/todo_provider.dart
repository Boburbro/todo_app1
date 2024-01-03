import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

class ToDoProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<ToDo> _list = [
    ToDo(rId: "q", title: "aa", date: DateTime.now()),
  ];
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

  void deleteToDo(String toDoId) {
    _list.removeWhere((toDo) => toDoId == toDo.rId);
    notifyListeners();
  }

  void addNewToDo(String title, DateTime time) {
    _list.add(ToDo(rId: UniqueKey().toString(), title: title, date: time));
    notifyListeners();
  }

  Future<void> addToBaza() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('data')) {
      print("ad");
    }
  }

  Future<void> _getAllData() async{

    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('data')) {
      print("ad");
    }

  }
}
