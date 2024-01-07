import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/todo_provider.dart';

class AddToDoItem extends StatefulWidget {
  const AddToDoItem({required this.id, super.key});

  final String id;

  @override
  State<AddToDoItem> createState() => _AddToDoItemState();
}

class _AddToDoItemState extends State<AddToDoItem> {
  DateTime? selectedDate;
  TextEditingController controller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  var _hasTime = true;

  @override
  void initState() {
    if (widget.id.isNotEmpty) {
      final data =
          Provider.of<ToDoProvider>(context, listen: false).item(widget.id);
      selectedDate = data.date;
      controller.text = data.title;
    }
    super.initState();
  }

  void openKalendar(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    ).then((time) {
      setState(() {
        selectedDate = time;
        _hasTime = true;
      });
    });
  }

  void vol() {
    if (selectedDate == null) {
      setState(() {
        _hasTime = false;
      });
    }
  }

  void save() {
    vol();
    _formKey.currentState!.validate();
    if (selectedDate == null || controller.text.isEmpty) {
      return;
    }
    if (widget.id.isNotEmpty) {
      final isDone = Provider.of<ToDoProvider>(context, listen: false)
          .item(widget.id)
          .isDone;
      Provider.of<ToDoProvider>(context, listen: false).updateItem(
        widget.id,
        controller.text,
        selectedDate!,
        isDone,
      );
    } else {
      Provider.of<ToDoProvider>(context, listen: false)
          .addNewToDo(controller.text, selectedDate!);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom > 0
              ? MediaQuery.of(context).viewInsets.bottom + 20
              : 100,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "It should not be empty";
                    }
                  },
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Name"),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    selectedDate == null
                        ? Text(
                            "Day not selected",
                            style: TextStyle(
                              color: _hasTime ? null : Colors.red,
                            ),
                          )
                        : Text(
                            DateFormat("EEE, d MMM yyy").format(selectedDate!)),
                    TextButton(
                      onPressed: () => openKalendar(context),
                      child: const Text('Select day'),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("CANCEL"),
                    ),
                    ElevatedButton(
                        onPressed: () => save(), child: const Text("SAVE"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
