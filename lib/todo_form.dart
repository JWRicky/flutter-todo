import 'package:flutter/material.dart';
import 'package:test_app/todo.dart';
import 'package:test_app/todo_list_store.dart';

class TodoForm extends StatefulWidget {

  final Todo? todo;

  const TodoForm({Key? key, this.todo}) : super(key: key);

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {


  final TodoListStore _store = TodoListStore();

  late bool _isCreated;   //新規追加かどうか

  late String _title;

  late bool _done;

  late Todo todo;

  @override
  void initState() {

    super.initState();

    var todo = widget.todo;
    
    _title = todo?.title ?? "";

    _done = todo?.done ?? false;

    if (todo == null) {
      _isCreated = false;
    }
    else {
      _isCreated = true;
      this.todo = todo;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_isCreated ? '更新画面' : '登録画面'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),

        child: Column(
          children: <Widget>[

            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "todoを入力",
              ),
              controller: TextEditingController(text: _title),
              onChanged: (String value) {
                _title = value;
              },
            ),
            
            Container(
              margin: EdgeInsets.only(top: 20),

              child: Column(
                children: [

                  SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {

                        _isCreated ? 
                        _store.update(widget.todo!, _done, _title) :
                        _store.add(_done, _title); 

                        Navigator.of(context).pop();
                      },
                      child: Text(
                        _isCreated ? "更新する" : "追加する"
                      ),
                    ),
                  ),

                  Visibility(
                    visible: (_isCreated && _done) ? true : false,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child:  SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {

                            if (_isCreated) {
                              setState(() => _store.delete(todo));
                            }
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "削除する"
                          ),
                        ),
                      ),
                    )
                  ) 

                ],
              ),
            )
          ],
        ),
      )
    );
  }
}