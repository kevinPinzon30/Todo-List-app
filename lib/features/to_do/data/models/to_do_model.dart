import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  final String title;
  final String description;
  String? id;
  final Timestamp createdAt;

  ToDo({
    required this.title,
    required this.description,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      title: map['title'],
      description: map['description'],
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt,
    };
  }

  List<Object?> get props => [
        title,
        description,
        createdAt,
      ];
}
