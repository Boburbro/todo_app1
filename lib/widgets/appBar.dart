import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class appBar extends StatelessWidget {
  const appBar({
    required this.openPicker,
    required this.now,
    required this.addDay,
    required this.minusDay,
    super.key,
  });

  final Function openPicker;
  final Function addDay;
  final Function minusDay;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => minusDay(),
          icon: const Icon(Icons.arrow_left_rounded, size: 35),
        ),
        TextButton(
          onPressed: () {
            openPicker(context);
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${DateFormat("EEEE").format(now)}, ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                TextSpan(
                  text: DateFormat("d MMM").format(now),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                )
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () => addDay(),
          icon: const Icon(Icons.arrow_right_rounded, size: 35),
        ),
      ],
    );
  }
}
