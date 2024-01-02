import 'package:flutter/material.dart';
import 'package:todoey/models/todo.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({
    super.key,
    required this.tasks,
    required this.update,
  });

  final List<Todo> tasks;
  final Function update;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    late String taskTitle;
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 30.0,
              ),
            ),
            TextFormField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(),
              onChanged: (value) => taskTitle = value,
              validator: (value) {
                if (tasks.any((element) => element.title == value)) {
                  return 'Task Already Exists!';
                }

                if (value == null) return 'Task can\'t be null';
                return null;
              },
            ),
            MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  update(Todo(title: taskTitle));
                }
              },
              color: Colors.lightBlueAccent,
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
