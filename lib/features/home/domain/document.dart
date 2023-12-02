// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DocumentModel {
  final String title;
  final String id;
  final DateTime createdAt;
  final List content;
  final String uid;
  DocumentModel({
    required this.title,
    required this.id,
    required this.createdAt,
    required this.content,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'content': content,
      'uid': uid,
    };
  }

  String toJson() => json.encode(toMap());

  factory DocumentModel.fromJson(String source) =>
      DocumentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  DocumentModel copyWith({
    String? title,
    String? id,
    DateTime? createdAt,
    List? content,
    String? uid,
  }) {
    return DocumentModel(
      title: title ?? this.title,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      uid: uid ?? this.uid,
    );
  }

  @override
  String toString() {
    return 'Document(title: $title, id: $id, createdAt: $createdAt, content: $content, uid: $uid)';
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      title: map['title'] ?? '',
      id: map['_id'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']) ??
          DateTime.now(),
      content: List.from((map['content'])) ?? [],
      uid: map['uid'] ?? '',
    );
  }
}
