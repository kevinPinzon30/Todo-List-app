import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getCollection(String collectionName) async {
    // return await _firebaseFirestore.collection(collectionName).get();
    return await _firebaseFirestore
        .collection(collectionName)
        .orderBy('createdAt', descending: false)
        .get();
  }

  Future<DocumentSnapshot> getDocument(
    String collectionName,
    String documentId,
  ) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(documentId)
        .get();
  }

  // get document from collection where field == value
  Future<DocumentSnapshot?> getDocumentWithQuery(
    String collectionName,
    Object field,
    Object value,
  ) async {
    final QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection(collectionName)
        .where(field, isEqualTo: value)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      return null;
    }
  }

  Future<void> addDocument(
    String collectionName,
    Map<String, dynamic> data,
  ) async {
    await _firebaseFirestore.collection(collectionName).add(data);
  }

  Future<void> updateDocument(
    String collectionName,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    await _firebaseFirestore
        .collection(collectionName)
        .doc(documentId)
        .update(data);
  }

  Future<DocumentSnapshot<Object?>> getDocumentFromReference(
    DocumentReference documentReference,
  ) async {
    return await documentReference.get();
  }

  Future<void> deleteDocument(String collectionName, String documentId) async {
    await _firebaseFirestore
        .collection(collectionName)
        .doc(documentId)
        .delete();
  }
}
