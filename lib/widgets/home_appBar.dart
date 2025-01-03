// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
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
