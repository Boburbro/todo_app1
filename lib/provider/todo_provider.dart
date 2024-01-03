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

  Future<void> deleteToDo(String toDoId) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('data')) {
      _list.removeWhere((toDo) => toDoId == toDo.rId);
      // ignore: no_leading_underscores_for_local_identifiers
      List<Map<String, dynamic>> _newList = [];
      for (var element in _list) {
        _newList.add({
          'rId': element.rId,
          'title': element.title,
          'date': element.date.toIso8601String(),
          "isDoen": element.isDone.toString()
        });
      }
      final data = jsonEncode(_newList);
      await prefs.setString('data', data);
    }

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
      // ignore: no_leading_underscores_for_local_identifiers
      List<Map<String, dynamic>> _newList = [];
      // ignore: avoid_function_literals_in_foreach_calls
      _list.forEach((element) {
        _newList.add({
          'rId': element.rId,
          'title': element.title,
          'date': element.date.toIso8601String(),
          "isDoen": element.isDone.toString()
        });
      });
      _newList.add({
        "rId": rId,
        "title": title,
        "date": time.toIso8601String(),
        "isDone": "false"
      });
      final data = jsonEncode(_newList);
      await prefs.setString('data', data);
      _list.add(ToDo(rId: rId, title: title, date: time));
    }
    notifyListeners();
  }

  Future<void> getAllData() async {
    _list = [];
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('data')) {
      final dataJson = prefs.getString('data');
      final List data = jsonDecode(dataJson!);
      for (var element in data) {
        _list.add(
          ToDo(
            rId: element['rId'],
            title: element["title"],
            date: DateTime.parse(
              element['date'],
            ),
            isDone: element['isDone'],
          ),
        );
      }
    }
    notifyListeners();
  }

  // Future<void> changeIsDoneWithDb(String rId, String newIsDone) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (prefs.containsKey('data')) {
  //     final dataJson = prefs.getString('data');
  //     final List data = jsonDecode(dataJson!);

  //     final dataIndex = data.indexWhere((element) => element['rId'] == rId);

  //     data[dataIndex]['isDone'] = newIsDone;

  //     final data1 = jsonEncode(data);
  //     await prefs.setString('data', data1);

  //     List<ToDo> _list1 = [];
  //     for (var element in data) {
  //       _list1.add(
  //         ToDo(
  //           rId: element['rId'],
  //           title: element["title"],
  //           date: DateTime.parse(
  //             element['date'],
  //           ),
  //         ),
  //       );
  //     }
  //     _list = _list1;
  //   }
  //   notifyListeners();
  // }
}
