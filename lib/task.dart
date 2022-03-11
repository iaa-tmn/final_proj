
class Task{
  final int? userid;
  final int? id;
  final String? title;
  bool? completed;

  Task({
    required this.userid,
    required this.id,
    required this.title,
    required this.completed});

  factory Task.fromJSON(Map<String, dynamic> json){
    return Task(
      userid: json['userid'],
      id: json['id'],
      title:json['title'],
      completed: json['completed'],
    );
  }
}