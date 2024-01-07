import 'package:flutter/material.dart';
import 'package:todo_app/provider/sql_helper.dart';

class ToDo with ChangeNotifier {
  final String rId;
  final String title;
  final DateTime date;
  bool isDone;

  ToDo({
    required this.rId,
    required this.title,
    required this.date,
    this.isDone = false,
  });

  Future<void> changeIsDone() async {
    var oldData = isDone;
    try {
      await SqlHelper.updateItem(
              rId, title, date.toIso8601String(), "${!oldData}")
          .then((value) => isDone = !oldData);
    } catch (e) {
      isDone = oldData;
    }
    notifyListeners();
  }
}
