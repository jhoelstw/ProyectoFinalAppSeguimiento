import 'package:app_seguimiento/infrastructure/controllers/conexion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// C: CREATE
Future insertUsuario({required Map<String, dynamic> json}) async {
  await insert(json: json, collectionId: 'usuarios');
}

// R: READ
Future<Map<String, dynamic>> getUsuario({required String codigo}) async {
  return await getDocument(codigo: codigo, collectionId: 'usuarios');
}
Future<List<Map<String, dynamic>>> getUsuarios() async {
  return await getDocuments(collectionId: 'usuarios');
}

// U: UPDATE
Future updateUsuario({required String codigo, required String field, required String newValue}) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('usuarios').where('codigo', isEqualTo: codigo).get();
  for (var document in snapshot.docs) {
    document.reference.update({field:newValue});
  }
}

// D: DELETE
Future deleteUsuario({required String codigo}) async {
  await deleteDocument(codigo: codigo, collectionId: 'usuarios');
}