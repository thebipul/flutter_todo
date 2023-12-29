import 'package:flutter/material.dart';
import 'todo_list_store.dart';
import 'todo.dart';

class TodoInputPage extends StatefulWidget {
  final Todo? todo;

  const TodoInputPage({Key? key, this.todo}) : super(key: key);

  @override
  State<TodoInputPage> createState() => _TodoInputPageState();
}

class _TodoInputPageState extends State<TodoInputPage> {
  final TodoListStore _todoListStore = TodoListStore();

  late bool _isCreateTodo;

  late String _title;

  late String _description;

  late bool _done;

  late String _createDate;

  late String _updateDate;

  @override
  void initState() {
    super.initState();
    var todo = widget.todo;

    _title = todo?.title ?? '';
    _description = todo?.description ?? '';
    _done = todo?.done ?? false;
    _createDate = todo?.createDate ?? '';
    _updateDate = todo?.updateDate ?? '';
    _isCreateTodo = todo == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreateTodo ? 'Add Todo' : 'Edit Todo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(children: <Widget>[
          CheckboxListTile(
            title: const Text('Done'),
            value: _done,
            onChanged: (bool? value) {
              setState(() {
                _done = value ?? false;
              });
            },
          ),
          const SizedBox(height: 20),
          TextField(
            autofocus: true,
            decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                )),
            controller: TextEditingController(text: _description),
            onChanged: (String value) {
              _description = value;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (_isCreateTodo) {
                    _todoListStore.add(_done, _title, _description);
                  } else {
                    _todoListStore.update(
                        widget.todo!, _done, _title, _description);
                  }
                  Navigator.of(context).pop();
                },
                child: Text(
                  _isCreateTodo ? 'Add Todo' : 'Edit Todo',
                  style: const TextStyle(color: Colors.white),
                )),
          ),
          const SizedBox(height: 20),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.blue)),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue),
                  ))),
          const SizedBox(height: 20),
          Text("Create Date: $_createDate"),
          Text("Update Date: $_updateDate")
        ]),
      ),
    );
  }
}
