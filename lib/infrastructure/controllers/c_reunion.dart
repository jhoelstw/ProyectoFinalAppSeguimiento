import 'package:app_seguimiento/infrastructure/controllers/conexion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// C: CREATE
Future insertReunion({required Map<String, dynamic> json}) async {
  await insert(json: json, collectionId: 'reuniones');
}

// R: READ
Future<Map<String, dynamic>> getReunion({required String codigo}) async {
  return await getDocument(codigo: codigo, collectionId: 'reuniones');
}
Future<List<Map<String, dynamic>>> getReuniones() async {
  return await getDocuments(collectionId: 'reuniones');
}

// U: UPDATE
Future updateReunion({required String codigo, required String field, required String newValue}) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('reuniones').where('codigo', isEqualTo: codigo).get();
  for (var document in snapshot.docs) {
    document.reference.update({field:newValue});
  }
}

// D: DELETE
Future deleteReunion({required String codigo}) async {
  await deleteDocument(codigo: codigo, collectionId: 'reuniones');
}