class User{
  String id;
  String name;

  User(this.name, this.id);

  User.fromJson(Map<String, dynamic> json):
    id = json['id'].toString(),
    name = json['teacherName']??json['firstName'];
}

