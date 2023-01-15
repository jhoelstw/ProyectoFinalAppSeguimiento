import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// C: CREATE
Future insert({required Map<String, dynamic> json, required String collectionId}) async {
  final doc = FirebaseFirestore.instance.collection(collectionId).doc();
  await doc.set(json);
}

// R: READ
Future<Map<String, dynamic>> getDocument({required String codigo, required String collectionId}) async {
  Map<String,dynamic> doc = {};
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection(collectionId).where('codigo', isEqualTo: codigo).get();
  for (var document in snapshot.docs) {
    doc = document.data();
  }
  return doc;
}
Future<List<Map<String, dynamic>>> getDocumentsWhere({required String value, required String collectionId, required String field}) async {
  
  List<Map<String, dynamic>> docs = [];
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection(collectionId).where(field, isEqualTo: value).get();
  for (var document in snapshot.docs) {
    docs.add(document.data());
  }
  return docs;
}
Future<List<Map<String, dynamic>>> getDocuments({required String collectionId}) async {
  List<Map<String,dynamic>> docs = [];
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection(collectionId).get();
  for (var document in snapshot.docs) {
    docs.add(document.data());
  }
  return docs;
}

// U: UPDATE
Future updateDocument({required String codigo, required String collectionId, required String field, required String newValue}) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection(collectionId).where('codigo', isEqualTo: codigo).get();
  for (var document in snapshot.docs) {
    document.reference.update({field:newValue});
  }
}

// D: DELETE
Future deleteDocument({required String codigo, required String collectionId}) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection(collectionId).where('codigo', isEqualTo: codigo).get();
  for (var document in snapshot.docs) {
    document.reference.delete();
  }
}

Future deleteDocumentWhereTwo({required String collectionId, required String field1, required String value1, required String field2, required String value2}) async {
  QuerySnapshot<Map<String,dynamic>> snapshot = await FirebaseFirestore.instance.collection(collectionId).where(field1, isEqualTo: value1).where(field2, isEqualTo: value2).get();
  for (var document in snapshot.docs) {
    document.reference.delete();
  }
}