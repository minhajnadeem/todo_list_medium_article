import 'package:flutter/foundation.dart';

import '../models/todo.dart';

/// CONCEPT 1: ChangeNotifier
/// -------------------------
/// Our TodoProvider extends ChangeNotifier. This means:
/// - It holds the app state (list of todos)
/// - When state changes, we call notifyListeners()
/// - Any widget listening (e.g. via Consumer) will rebuild
class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  void addTask(String title) {
    if (title.trim().isEmpty) return;
    _todos.add(Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
    ));
    notifyListeners(); // Tell UI: "state changed, please rebuild"
  }

  void deleteTask(String id) {
    _todos.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void deleteAllTasks() {
    _todos.clear();
    notifyListeners();
  }

  void editTask(String id, String newTitle) {
    if (newTitle.trim().isEmpty) return;
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;
    _todos[index] = _todos[index].copyWith(title: newTitle.trim());
    notifyListeners();
  }

  void toggleDone(String id) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;
    _todos[index] = _todos[index].copyWith(isDone: !_todos[index].isDone);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;
    _todos[index] = _todos[index].copyWith(isFavorite: !_todos[index].isFavorite);
    notifyListeners();
  }
}
