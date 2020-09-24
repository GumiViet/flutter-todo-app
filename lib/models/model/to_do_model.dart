class TodoModel {
  int id;
  String name;
  int value;

  TodoModel({this.id, this.name, this.value});

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'] as int,
        value: json['value'] as int,
        name: json['name'] as String,
      );

  List<TodoModel> getListFromJson(List<dynamic> list) {
    return list.map((e) => TodoModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'value': this.value,
        'name': this.name,
      };
}
