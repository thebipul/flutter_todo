import 'todo.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class TodoListStore {
  final String _saveKey = "TODO_LIST";

  List<Todo> _todoList = [];

  static final TodoListStore _instance = TodoListStore._internal();

  TodoListStore._internal();

  factory TodoListStore() {
    return _instance;
  }
  int count() {
    return _todoList.length;
  }

  Todo findByIndex(int index) {
    return _todoList[index];
  }

  String getDateTime() {
    var format = DateFormat('yyyy-MM-dd HH:mm:ss');
    var dateTime = format.format(DateTime.now());
    return dateTime;
  }

  void add(bool done, String title, String description) {
    var id = count() == 0 ? 1 : _todoList.last.id + 1;
    var dateTime = getDateTime();
    var todo = Todo(
      id,
      title,
      description,
      done,
      dateTime,
      dateTime,
    );
    _todoList.add(todo);
    save();
  }

  void update(Todo todo, bool done, [String? title, String? description]) {
    todo.done = done;
    if (title != null) {
      todo.title = title;
    }
    if (description != null) {
      todo.description = description;
    }
    todo.updateDate = getDateTime();
    save();
  }

  void delete(Todo todo) {
    _todoList.remove(todo);
    save();
  }

  void save() async {
    var prefs = await SharedPreferences.getInstance();
    var saveTargetList =
        _todoList.map((todo) => json.encode(todo.toJson())).toList();
    prefs.setStringList(_saveKey, saveTargetList);
  }

  void load() async {
    var prefs = await SharedPreferences.getInstance();
    var loadTargetList = prefs.getStringList(_saveKey) ?? [];
    _todoList =
        loadTargetList.map((todo) => Todo.fromJson(json.decode(todo))).toList();
  }
}
