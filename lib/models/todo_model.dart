// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MyToDo {
  String id;
  String authorId;
  String todo;
  bool isFinished = false;
  DateTime writeDate;
  DateTime date;
  MyToDo({
    required this.id,
    required this.authorId,
    required this.todo,
    required this.isFinished,
    required this.writeDate,
    required this.date,
  });

  MyToDo copyWith({
    String? id,
    String? authorId,
    String? todo,
    bool? isFinished,
    DateTime? writeDate,
    DateTime? date,
  }) {
    return MyToDo(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      todo: todo ?? this.todo,
      isFinished: isFinished ?? this.isFinished,
      writeDate: writeDate ?? this.writeDate,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'authorId': authorId,
      'todo': todo,
      'isFinished': isFinished,
      'writeDate': writeDate.millisecondsSinceEpoch,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory MyToDo.fromMap(Map<String, dynamic> map) {
    return MyToDo(
      id: map['id'] as String,
      authorId: map['authorId'] as String,
      todo: map['todo'] as String,
      isFinished: map['isFinished'] as bool,
      writeDate: DateTime.fromMillisecondsSinceEpoch(map['writeDate'] as int),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyToDo.fromJson(String source) => MyToDo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyToDo(id: $id, authorId: $authorId, todo: $todo, isFinished: $isFinished, writeDate: $writeDate, date: $date)';
  }

  @override
  bool operator ==(covariant MyToDo other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.authorId == authorId &&
      other.todo == todo &&
      other.isFinished == isFinished &&
      other.writeDate == writeDate &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      authorId.hashCode ^
      todo.hashCode ^
      isFinished.hashCode ^
      writeDate.hashCode ^
      date.hashCode;
  }
}
