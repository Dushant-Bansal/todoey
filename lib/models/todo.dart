// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoey/services/persistence.dart';

@immutable
class Todo {
  const Todo({required this.title, this.isDone = false});
  final String title;
  final bool isDone;

  Todo copyWith({String? title, bool? isDone}) {
    return Todo(title: title ?? this.title, isDone: isDone ?? this.isDone);
  }

  factory Todo.fromJson(Map<String, dynamic> json) =>
      Todo(title: json['title'], isDone: json['isDone']);

  Map<String, dynamic> toJson() => {'title': title, 'isDone': isDone};

  factory Todo.fromString(String task) => Todo.fromJson(json.decode(task));

  @override
  String toString() => '{"title": "$title", "isDone": $isDone}';
}

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier._(super.todos);

  List<Todo> get todos => state;

  static TodoNotifier init() {
    List<String> list = Persistence.getTasks();
    return TodoNotifier._(list.map<Todo>((e) => Todo.fromString(e)).toList());
  }

  Future<void> saveLocally() async {
    List<String> list = [];
    list.addAll(state.map((e) => e.toString()));
    await Persistence.addTasks(list);
  }

  void addTask(Todo task) {
    state = [...state, task];
    saveLocally();
  }

  void removeTask(String title) {
    state = [
      for (final todo in state)
        if (todo.title != title || !todo.isDone) todo,
    ];
    saveLocally();
  }

  void reorder(int oldIdx, int newIdx) {
    List<Todo> todos = state;
    final todo = todos[oldIdx];
    todos.removeAt(oldIdx);
    todos.insert(oldIdx < newIdx ? newIdx - 1 : newIdx, todo);
    state = todos;
    saveLocally();
  }

  void toggle(String title) {
    state = [
      for (final todo in state)
        if (todo.title == title) todo.copyWith(isDone: !todo.isDone) else todo
    ];
    Future.delayed(const Duration(seconds: 1), () => removeTask(title));
  }
}

final taskNotifierProvider = StateNotifierProvider<TodoNotifier, List<Todo>>(
  (ref) => TodoNotifier.init(),
);

final taskNotifierLoaderProvider =
    FutureProvider<void>((ref) async => await Persistence.init());
