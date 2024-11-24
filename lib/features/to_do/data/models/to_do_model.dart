
class ToDo {
  final String title;
  final String description;
  String? id;

  ToDo({
    required this.title,
    required this.description,
  });

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      title: map['title'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  List<Object?> get props => [
    title,
    description,
  ];
}
