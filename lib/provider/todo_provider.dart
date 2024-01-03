import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void deleteToDo(String toDoId) {
    _list.removeWhere((toDo) => toDoId == toDo.rId);
    notifyListeners();
  }

  Future<void> addNewToDo(String title, DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('data')) {
      final rId = UniqueKey().toString();
      final data = jsonEncode([
        {"rId": rId, "title": title, "date": time.toIso8601String()}
      ]);
      await prefs.setString('data', data);
      _list.add(ToDo(rId: rId, title: title, date: time));
    } else {
      final rId = UniqueKey().toString();
      List<Map<String, dynamic>> _newList = [];
      _list.forEach((element) {
        _newList.add({
          'rId': element.rId,
          'title': element.title,
          'date': element.date.toIso8601String(),
          "isDoen": element.isDone.toString()
        });
      });
      final data = jsonEncode([
        {
          "rId": rId,
          "title": title,
          "date": time.toIso8601String(),
          "isDone": "false"
        }
      ]);
      await prefs.setString('data', data);
      _list.add(ToDo(rId: rId, title: title, date: time));
    }
    notifyListeners();
  }

  Future<void> getAllData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('data')) {
      final dataJson = prefs.getString('data');
      final List data = jsonDecode(dataJson!);
      data.forEach((element) {
        _list.add(
          ToDo(
            rId: element['rId'],
            title: element["title"],
            date: DateTime.parse(
              element['date'],
            ),
          ),
        );
      });
    }
  }
}
