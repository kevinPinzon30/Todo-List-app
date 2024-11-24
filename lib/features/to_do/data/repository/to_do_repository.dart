import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/core/services/firestore_db.dart';
import 'package:todo/features/to_do/data/models/to_do_model.dart';

class TodoRepository {
  final FirestoreDatabase _db = FirestoreDatabase();

  Future<List<ToDo>> fetchToDos() async {
    QuerySnapshot<Object?> toDosCollection = await _db.getCollection(
      "todos",
    );

    List<ToDo> toDos = toDosCollection.docs
        .map(
          (e) => ToDo.fromMap(e.data() as Map<String, dynamic>)..id = e.id,
    )
        .toList();

    return toDos;
  }
}
