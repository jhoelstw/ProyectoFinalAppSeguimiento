import 'package:app_seguimiento/infrastructure/controllers/conexion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// C: CREATE
Future insertEntorno({required Map<String, dynamic> json}) async {
  await insert(json: json, collectionId: 'entornos');
}

// R: READ
Future<Map<String, dynamic>> getEntorno({required String codigo}) async {
  return await getDocument(codigo: codigo, collectionId: 'entornos');
}

Future<List<Map<String, dynamic>>> getEntornos() async {
  return await getDocuments(collectionId: 'entornos');
}

// U: UPDATE
Future updateEntorno(
    {required String codigo,
    required String field,
    required String newValue}) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('entornos')
      .where('codigo', isEqualTo: codigo)
      .get();
  for (var document in snapshot.docs) {
    document.reference.update({field: newValue});
  }
}

// D: DELETE
Future deleteEntorno({required String codigo}) async {
  await deleteDocument(codigo: codigo, collectionId: 'entornos');
}

Future deleteEntornoColaborador({required String entornoCodigo, required String colaboradorCodigo}) async {
  await deleteDocumentWhereTwo(collectionId: 'entornos-colaboradores', field1: 'codEntorno', value1: entornoCodigo, field2: 'codColaborador', value2: colaboradorCodigo);
}
Future deleteEntornoReunion({required String entornoCodigo, required String reunionCodigo}) async {
  await deleteDocumentWhereTwo(collectionId: 'entornos-reuniones', field1: 'codEntorno', value1: entornoCodigo, field2: 'codReunion', value2: reunionCodigo);
}
Future deleteEntornoEntregable({required String entornoCodigo, required String entregableCodigo}) async {
  await deleteDocumentWhereTwo(collectionId: 'entornos-entregables', field1: 'codEntorno', value1: entornoCodigo, field2: 'codEntregable', value2: entregableCodigo);
}

// TABLAS INTERMEDIAS
Future<List<Map<String, dynamic>>> getEntornoColaboradores(
    {required String codigo}) async {
  List<Map<String, dynamic>> colaboradores = [];
  List<Map<String, dynamic>> rows = await getDocumentsWhere(
      value: codigo,
      collectionId: 'entornos-colaboradores',
      field: 'codEntorno');
  List<String> colabCodes = rows
      .map((Map<String, dynamic> e) => e['codColaborador'].toString())
      .toList();
  for (var element in colabCodes) {
    colaboradores
        .add(await getDocument(codigo: element, collectionId: 'usuarios'));
  }
  return colaboradores;
}

Future<List<Map<String, dynamic>>> getEntornoReuniones(
    {required String codigo}) async {
  List<Map<String, dynamic>> reuniones = [];
  List<Map<String, dynamic>> rows = await getDocumentsWhere(
      value: codigo, collectionId: 'entornos-reuniones', field: 'codEntorno');
  List<String> reuCodes =
      rows.map((Map<String, dynamic> e) => e['codReunion'].toString()).toList();
  print('>>>>>>>>>>AQUI<<<<<<<<<<');
  print(reuCodes);
  for (var element in reuCodes) {
    reuniones
        .add(await getDocument(codigo: element, collectionId: 'reuniones'));
  }
  print('>>>>>>>>>>AQUI<<<<<<<<<<');
  print(reuniones);
  return reuniones;
}

Future<List<Map<String, dynamic>>> getEntornoEntregables(
    {required String codigo}) async {
  List<Map<String, dynamic>> entregables = [];
  List<Map<String, dynamic>> rows = await getDocumentsWhere(
      value: codigo, collectionId: 'entornos-entregables', field: 'codEntorno');
  List<String> entCodes = rows
      .map((Map<String, dynamic> e) => e['codEntregable'].toString())
      .toList();
  for (var element in entCodes) {
    entregables
        .add(await getDocument(codigo: element, collectionId: 'entregables'));
  }
  return entregables;
}

Future addEntornoColaborador(
    {required Map<String, dynamic> json, required String codigo}) async {
  await insert(json: json, collectionId: 'usuarios');
  await insert(
    json: {
      'codigo': '${codigo}-${json['codigo']}',
      'codEntorno': codigo,
      'codColaborador': json['codigo']
    },
    collectionId: 'entornos-colaboradores',
  );  
}

Future addEntornoReunion({required Map<String, dynamic> json, required String codigo}) async {
  await insert(json: json, collectionId: 'reuniones');
  await insert(
    json: {
      'codigo': '${codigo}-${json['codigo']}',
      'codEntorno': codigo,
      'codReunion': json['codigo']
    },
    collectionId: 'entornos-reuniones',
  ); 
}

Future addEntornoEntregable({required Map<String, dynamic> json, required String codigo}) async {
  await insert(json: json, collectionId: 'entregables');
  await insert(
    json: {
      'codigo': '${codigo}-${json['codigo']}',
      'codEntorno': codigo,
      'codEntregable': json['codigo']
    },
    collectionId: 'entornos-entregables',
  ); 
}