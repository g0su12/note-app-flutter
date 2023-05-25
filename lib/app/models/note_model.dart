import 'dart:convert';

class NoteModel {
  String category;
  DateTime date;
  String title;
  String? time;
  String content;
  String? location;
  List<dynamic>? tasks;
  int? id;

  NoteModel(
      {
        this.id,
        required this.content,
        this.location,
        this.tasks,
        required this.category,
        required this.date,
        required this.title,
        this.time,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      category: map['category'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      title: map['title'],
      time: map['time'],
      content: map['content'],
      location: map['location'],
      tasks: map['tasks'] != null ? jsonDecode(map['tasks']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'date': date.millisecondsSinceEpoch,
      'title': title,
      'time': time,
      'content': content,
      'location': location,
      'tasks': jsonEncode(tasks),
    };
  }
}