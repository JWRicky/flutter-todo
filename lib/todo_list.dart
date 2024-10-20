import 'package:flutter/material.dart';
import 'package:test_app/todo.dart';
import 'package:test_app/todo_form.dart';
import 'package:test_app/todo_list_store.dart';

class TodoList extends StatefulWidget {

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  final TodoListStore _store = TodoListStore();

  void _showTodoForm([Todo? todo]) async {

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder:(context) {
          return TodoForm(todo: todo);
        },
      )
    );

    setState(() {});
  }

  @override
  void initState() {

    super.initState();

    Future (
      () async {
        () => _store.get();
      }
    );
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Todoリスト"),
      ),
      body: ListView.builder(
        itemCount: _store.count(),
        itemBuilder: (context, index) {

        var item = _store.findByIndex(index);

          return GestureDetector(

              onTap: () {
                _showTodoForm(item);
              },

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
                    setState(() => _store.update(item, value!));
                  },
                ),
              ),
              
            ),
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: _showTodoForm,
        child: const Icon(Icons.add),
      ), 
    );
  }
}