

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/todo.dart';

class TodoListStore {

  static final TodoListStore _instance = TodoListStore._internal();

  TodoListStore._internal();

  factory TodoListStore() {
    return _instance;
  }


  List<Todo> _list = [];


  int count() {
    return _list.length; 
  }

  Todo findByIndex(int index) {
    return _list[index];
  }

  void get() async {

    var prefs = await SharedPreferences.getInstance();

    var target = prefs.getStringList('todo') ?? [];

    //StringList→Json→Map→TodoListに変換
    _list = target.map((m) => Todo.fromJson(json.decode(m))).toList();

  }

  void add(bool done, String title) {

    int id;

    if (count() == 0) {
      id = 1;
    }
    else {
      id = _list.last.id + 1;
    }

    var todo = Todo(id, title, done);

    _list.add(todo);
    save();
  }

  void delete(Todo todo) {

    _list.remove(todo);
    save();
  }

  void update(Todo todo, bool done, [String? title]) {

    todo.done = done;

    if (title != null) {
      todo.title = title;
    }

    save();
  }

  void save() async {

    var prefs = await SharedPreferences.getInstance();

    //TodoList→Map→Json→StringListに変換
    var target = _list.map((m) => json.encode(m.toJson())).toList();
    prefs.setStringList('todo', target);
  }


}