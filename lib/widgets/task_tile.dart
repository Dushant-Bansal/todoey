import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String title;
  final Function checkboxCallback;

  const TaskTile(
      {super.key,
      required this.title,
      required this.isChecked,
      required this.checkboxCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null),
        ),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
          onChanged: (newValue) {
            checkboxCallback(newValue);
          },
        ),
      ),
    );
  }
}
