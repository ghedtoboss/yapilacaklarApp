// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MyUser {
  String adSoyad;
  String id;
  String mail;
  MyUser({
    required this.adSoyad,
    required this.id,
    required this.mail,
  });

  MyUser copyWith({
    String? adSoyad,
    String? id,
    String? mail,
  }) {
    return MyUser(
      adSoyad: adSoyad ?? this.adSoyad,
      id: id ?? this.id,
      mail: mail ?? this.mail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adSoyad': adSoyad,
      'id': id,
      'mail': mail,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      adSoyad: map['adSoyad'] as String,
      id: map['id'] as String,
      mail: map['mail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MyUser(adSoyad: $adSoyad, id: $id, mail: $mail)';

  @override
  bool operator ==(covariant MyUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.adSoyad == adSoyad &&
      other.id == id &&
      other.mail == mail;
  }

  @override
  int get hashCode => adSoyad.hashCode ^ id.hashCode ^ mail.hashCode;
}
