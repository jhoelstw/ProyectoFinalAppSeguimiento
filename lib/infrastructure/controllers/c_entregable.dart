import 'package:app_seguimiento/infrastructure/controllers/conexion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// C: CREATE
Future insertEntregable({required Map<String, dynamic> json}) async {
  await insert(json: json, collectionId: 'entregables');
}

// R: READ
Future<Map<String, dynamic>> getEntregable({required String codigo}) async {
  return await getDocument(codigo: codigo, collectionId: 'entregables');
}
Future<List<Map<String, dynamic>>> getEntregables() async {
  return await getDocuments(collectionId: 'entregables');
}

// U: UPDATE
Future updateEntregable({required String codigo, required String field, required String newValue}) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('entregables').where('codigo', isEqualTo: codigo).get();
  for (var document in snapshot.docs) {
    document.reference.update({field:newValue});
  }
}

Future updateEntregableEstado({required String codigo, required bool newValue}) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('entregables').where('codigo', isEqualTo: codigo).get();
  for (var document in snapshot.docs) {
    document.reference.update({'estado':newValue});
  }
}

// D: DELETE
Future deleteEntregable({required String codigo}) async {
  await deleteDocument(codigo: codigo, collectionId: 'entregables');
}

// ENTREGABLES DEL USUARIO ACTUAL
Future<List<Map<String, dynamic>>> getTareas({required String codigoUsuario}) async {
  return await getDocumentsWhere(value: codigoUsuario, collectionId: 'entregables', field: 'responsable');
}