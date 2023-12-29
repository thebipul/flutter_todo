import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String item;
  final VoidCallback onDelete;

  TodoItem({required this.item, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      style: ListTileStyle.drawer,
      title: Text(item),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    ));
  }
}
