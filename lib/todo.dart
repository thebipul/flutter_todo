class Todo {
  late int id;
  late String title;
  late String description;
  late bool done;
  late String createDate;
  late String updateDate;

  Todo(
    this.id,
    this.title,
    this.description,
    this.done,
    this.createDate,
    this.updateDate,
  );

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'done': done,
      'createDate': createDate,
      'updateDate': updateDate,
    };
  }

  Todo.fromJson(Map json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    done = json['done'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }
}
