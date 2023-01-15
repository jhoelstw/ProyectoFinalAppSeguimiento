import 'package:app_seguimiento/domain/entitites/reunion.dart';
import 'package:app_seguimiento/infrastructure/controllers/c_reunion.dart';


// C: CREATE
Future insertReunionEntity({required Reunion reunion}) async {
  await insertReunion(json: reunion.toJson());
}

// R: READ
Future<Reunion> getReunionEntity({required String codigo}) async {
  return Reunion.fromJson(await getReunion(codigo: codigo));
}
Future<List<Reunion>> getReunionesEntity() async {
  return (await getReuniones()).map((e) => Reunion.fromJson(e)).toList();
}

// U: UPDATE
Future updateReunionEntity({required String codigo, required String field, required String newValue}) async {
  await updateReunion(codigo: codigo, field: field, newValue: newValue);
}

// D: DELETE
Future deleteReunionEntity({required String codigo}) async {
  await deleteReunion(codigo: codigo);
}