// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MyNote {
  String title;
  String content;
  String id;
  String authorId;
  DateTime writeDate;
  MyNote({
    required this.title,
    required this.content,
    required this.id,
    required this.authorId,
    required this.writeDate,
  });

  MyNote copyWith({
    String? title,
    String? content,
    String? id,
    String? authorId,
    DateTime? writeDate,
  }) {
    return MyNote(
      title: title ?? this.title,
      content: content ?? this.content,
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      writeDate: writeDate ?? this.writeDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'id': id,
      'authorId': authorId,
      'writeDate': writeDate.millisecondsSinceEpoch,
    };
  }

  factory MyNote.fromMap(Map<String, dynamic> map) {
    return MyNote(
      title: map['title'] as String,
      content: map['content'] as String,
      id: map['id'] as String,
      authorId: map['authorId'] as String,
      writeDate: DateTime.fromMillisecondsSinceEpoch(map['writeDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyNote.fromJson(String source) =>
      MyNote.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyNote(title: $title, content: $content, id: $id, authorId: $authorId, writeDate: $writeDate)';
  }

  @override
  bool operator ==(covariant MyNote other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.content == content &&
        other.id == id &&
        other.authorId == authorId &&
        other.writeDate == writeDate;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        content.hashCode ^
        id.hashCode ^
        authorId.hashCode ^
        writeDate.hashCode;
  }
}
