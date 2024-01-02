import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_tile.dart';
import 'package:todoey/models/todo.dart';

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(taskNotifierProvider);
    return ReorderableListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, index) {
        return TaskTile(
          key: Key(data[index].title),
          title: data[index].title,
          isChecked: data[index].isDone,
          checkboxCallback: (value) {
            ref.read(taskNotifierProvider.notifier).toggle(data[index].title);
          },
        );
      },
      onReorder: (int oldIndex, int newIndex) =>
          ref.read(taskNotifierProvider.notifier).reorder(oldIndex, newIndex),
    );
  }
}
