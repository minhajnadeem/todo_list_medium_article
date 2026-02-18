# Todo App with Provider — A Flutter State Management Guide

A simple Flutter Todo app built to demonstrate **Provider** for state management. This project doubles as a learning resource: you can run the app, explore the code, and use this README as an article to understand the three core concepts — **ChangeNotifier**, **ChangeNotifierProvider**, and **Consumer**.

**By [DevMinhaj](https://www.devminhaj.me)** · [www.devminhaj.me](https://www.devminhaj.me)

---

## What This App Does

- **Add** tasks (FAB + dialog)
- **Edit** tasks (edit icon on each task)
- **Delete** a single task (delete icon or swipe left)
- **Delete all** tasks (AppBar icon with confirmation)
- **Mark as done** (circle icon)
- **Mark as favorite** (star icon)

Themes: light (teal primary, soft background) and dark (navy primary), following system setting.

---

## How to Run

**Prerequisites:** Flutter SDK installed.

```bash
cd todo_list_medium_article
flutter pub get
flutter run
```

Place your logo at `assets/images/devmj.png` for splash and in-app branding (optional; the app handles a missing asset).

---

## Project Structure

```
lib/
├── main.dart              # App entry, themes, ChangeNotifierProvider
├── models/
│   └── todo.dart          # Todo model (id, title, isDone, isFavorite)
├── providers/
│   └── todo_provider.dart # ChangeNotifier: state + business logic
└── screens/
    ├── splash_screen.dart # Logo splash, then navigates to TodoScreen
    └── todo_screen.dart  # Todo list UI, Consumer, dialogs
```

---

## Learning Article: Provider in Three Concepts

Provider helps you manage **state** (data that can change and should update the UI) in a clear way. In this app we use three pieces: the class that holds state, the widget that provides it, and the widget that listens to it.

---

### 1. ChangeNotifier — The “brain” that holds state

**What it is:** A class (from `package:flutter/foundation.dart`) that:

- Holds your app state (e.g. a list of todos).
- Exposes methods to change that state (add, delete, edit, toggle).
- Calls **`notifyListeners()`** whenever something changes so the UI can react.

**In this app:** `TodoProvider` in `lib/providers/todo_provider.dart` extends `ChangeNotifier`.

- **State:** a private list `_todos` and a public getter `todos`.
- **Methods:** `addTask`, `deleteTask`, `deleteAllTasks`, `editTask`, `toggleDone`, `toggleFavorite`.
- Every method that changes the list calls **`notifyListeners()`** at the end.

Important: if you forget `notifyListeners()`, the UI will not update even though the list changed.

```dart
class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  void addTask(String title) {
    // ... add to _todos ...
    notifyListeners(); // ← UI updates because of this
  }
  // ... other methods, each ending with notifyListeners()
}
```

**Takeaway:** Put your data and the logic that changes it in a class that extends `ChangeNotifier`, and call `notifyListeners()` after every change.

---

### 2. ChangeNotifierProvider — Making the “brain” available to the tree

**What it is:** A widget that:

- **Creates** your ChangeNotifier once (e.g. `TodoProvider()`).
- **Provides** it to the widget tree so any descendant can access it (via `Consumer` or `context.read<TodoProvider>()`).

**In this app:** In `lib/main.dart`, the `MaterialApp` is wrapped with `ChangeNotifierProvider`.

```dart
return ChangeNotifierProvider(
  create: (_) => TodoProvider(),
  child: MaterialApp(
    // ...
    home: const SplashScreen(),
  ),
);
```

Because of this, every screen and dialog that lives under `MaterialApp` can get the same `TodoProvider` instance. You typically put the provider high in the tree (e.g. around the app) so the state is shared where needed.

**Takeaway:** Wrap the part of the app that needs the state with `ChangeNotifierProvider` and use `create` to build your ChangeNotifier once.

---

### 3. Consumer — Listening and rebuilding when state changes

**What it is:** A widget that:

- **Listens** to a provider (e.g. `TodoProvider`).
- When that provider calls **`notifyListeners()`**, only the **Consumer** (and its subtree) rebuilds — not the whole app.
- Its **builder** receives `(context, provider, child)` so you can use `provider.todos` (or any method) to build the UI.

**In this app:** The main list is built with a `Consumer<TodoProvider>` in `lib/screens/todo_screen.dart` (the `_TodoList` widget).

- When the user adds, deletes, or toggles a task, `TodoProvider` calls `notifyListeners()`.
- Only this `Consumer` rebuilds and shows the updated list.

```dart
return Consumer<TodoProvider>(
  builder: (context, todoProvider, child) {
    final todos = todoProvider.todos;
    if (todos.isEmpty) {
      return Center(/* empty state */);
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => _TodoTile(todo: todos[index]),
    );
  },
);
```

We also use `Consumer<TodoProvider>` in the AppBar to show the “Delete all” button only when `todos` is not empty.

When you only need to **call** the provider (e.g. add or delete) without **listening** to changes, use **`context.read<TodoProvider>()`** instead of `Consumer` — for example in button callbacks and dialogs.

**Takeaway:** Use `Consumer<YourProvider>` when a part of the UI must **rebuild** when the provider’s state changes; use `context.read<YourProvider>()` when you only need to **trigger an action**.

---

## Flow in One Sentence

**ChangeNotifier** holds the state and calls **`notifyListeners()`**; **ChangeNotifierProvider** gives that object to the tree; **Consumer** (or `context.read`) uses it so the right parts of the UI update or react when state changes.

---

## Quick Reference

| Concept               | Role in this app                                      |
|-----------------------|--------------------------------------------------------|
| **ChangeNotifier**    | `TodoProvider`: list + methods + `notifyListeners()`  |
| **ChangeNotifierProvider** | Wraps the app in `main.dart`, `create: (_) => TodoProvider()` |
| **Consumer**          | List body and “Delete all” button; rebuild on change  |
| **context.read**      | Dialogs and buttons that call add / edit / delete     |

---

## About

Built for learning and teaching Flutter state management with Provider. For more tutorials and projects, visit **[www.devminhaj.me](https://www.devminhaj.me)**.

---

## License

This project is for learning and demonstration. Use it freely for your own study or articles.
