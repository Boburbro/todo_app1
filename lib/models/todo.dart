import 'package:flutter/material.dart';

class ToDo with ChangeNotifier {
  final String rId;
  final String title;
  final DateTime date;
  bool isDone = false;

  ToDo({required this.rId, required this.title, required this.date});

  void changeIsDone() {
    isDone = !isDone;
    notifyListeners();
  }
}
