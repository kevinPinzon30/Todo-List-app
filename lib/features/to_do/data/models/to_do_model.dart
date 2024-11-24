
class ToDo {
  final String name;
  String? id;

  ToDo({
    required this.name,
  });

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  List<Object?> get props => [
    name,
  ];
}
