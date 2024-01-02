import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoey/models/todo.dart';
import 'package:todoey/widgets/task_list.dart';
import 'add_task_screen.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskNotifierLoaderProvider);

    return tasks.when(
        data: (_) {
          final data = ref.watch(taskNotifierProvider);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.lightBlueAccent,
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      color: const Color(0xFF757575),
                      child: AddTaskScreen(
                        tasks: data,
                        update: (Todo task) {
                          ref.read(taskNotifierProvider.notifier).addTask(task);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
              ),
            ),
            backgroundColor: Colors.lightBlueAccent,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 60.0, bottom: 30.0, left: 30.0, right: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30.0,
                        child: Icon(
                          Icons.list,
                          color: Colors.lightBlueAccent,
                          size: 30.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Todoey',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${data.length} tasks',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: const TaskList(),
                  ),
                )
              ],
            ),
          );
        },
        error: (_, __) => const Scaffold(body: Center(child: Text('Error'))),
        loading: () => const Scaffold(body: Center(child: Text('Loading...'))));
  }
}
