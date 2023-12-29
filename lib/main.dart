import 'package:flutter/material.dart';
import 'todo_list_page.dart';

void main() {
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo List",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TodoListPage(),
    );
  }
}
