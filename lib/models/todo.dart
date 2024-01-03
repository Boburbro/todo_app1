import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

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
    final prefs = await SharedPreferences.getInstance();
    var old = isDone;
    isDone = !old;
    try {
      if (prefs.containsKey('data')) {
        final dataJson = prefs.getString('data');
        final List data = jsonDecode(dataJson!);

        final dataIndex = data.indexWhere((element) => element['rId'] == rId);

        data[dataIndex]['isDone'] = !old;

        final data1 = jsonEncode(data);

        await prefs.setString('data', data1);
      }
    } catch (e) {
      print(e);
      isDone = old;
    }
    notifyListeners();
  }
}
