
class Todo {


  late int id;

  late String title;

  late bool done;

  Todo(
    this.id,
    this.title,
    this.done,
  );

  Todo.fromJson(Map json) {

    id = json['id'];
    title = json['title'];
    done = json['done'];
  }

  toJson() {

    return {
      'id': id,
      'title': title,
      'done': done,
    };
  }


}