import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'todo.dart';
import 'todo_input_page.dart';
import 'todo_list_store.dart';

class TodoListPage extends StatefulWidget {
  // const TodoListPage({super.key});

  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TodoListStore _todoListStore = TodoListStore();

  void _pushTodoInputPage({Todo? todo}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return TodoInputPage(todo: todo);
      }),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    Future(
      () async {
        setState(() => _todoListStore.load());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: _todoListStore.count(),
        itemBuilder: (context, index) {
          var item = _todoListStore.findByIndex(index);

          return Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  onPressed: (context) {
                    _pushTodoInputPage(todo: item);
                  },
                  label: 'Edit',
                  backgroundColor: Colors.yellow,
                  icon: Icons.edit,
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() => _todoListStore.delete(item));
                  },
                  label: 'Delete',
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                ),
              ],
            ),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: ListTile(
                leading: Text(item.id.toString()),
                title: Text(item.title),
                trailing: Checkbox(
                  value: item.done,
                  onChanged: (bool? value) {
                    setState(() => _todoListStore.update(item, value!));
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pushTodoInputPage();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
