import 'package:app_seguimiento/domain/entitites/entregable.dart';
import 'package:app_seguimiento/infrastructure/entity_managers/e_entorno.dart';
import 'package:app_seguimiento/infrastructure/entity_managers/e_entregable.dart';
import 'package:app_seguimiento/variables_globales.dart';
import 'package:app_seguimiento/widgets/w_tarea_card.dart';
import 'package:flutter/material.dart';

class PaginaTareas extends StatefulWidget {
  PaginaTareas({super.key});

  @override
  State<PaginaTareas> createState() => _PaginaTareasState();
}

class _PaginaTareasState extends State<PaginaTareas> {
  List<dynamic> estados = [];
  int ncompletos = 0;
  int ntareas = 0;

  Future<List<Entregable>> getTareas() async {
    List<Entregable> tareas =
        await getEntornoTareasEntity(entornoCodigo: Global.entorno!.codigo, usuarioCodigo: Global.usuario!.codigo);
    estados = tareas.map((Entregable e) => e.estado).toList();
    ntareas = tareas.length;
    ncompletos =
        tareas.where((Entregable element) => (element.estado == true)).length;
    return tareas;
  }

  Future<void> refresh() async {
    List<Entregable> tareas =
        await getEntornoTareasEntity(entornoCodigo: Global.entorno!.codigo, usuarioCodigo: Global.usuario!.codigo);
    estados = tareas.map((Entregable e) => e.estado).toList();
    ntareas = tareas.length;
    ncompletos =
        tareas.where((Entregable element) => (element.estado == true)).length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: FutureBuilder(
                  future: getTareas(),
                  builder: (context, snapshot) {
                    return Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  '${ncompletos}',
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                ),
                                Text('Realizadas'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '/',
                              style: TextStyle(
                                fontSize: 60,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  '${ntareas}',
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                ),
                                Text('Asignadas')
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: FutureBuilder(
                  future: getTareas(),
                  builder: (context, snapshot) {
                    return Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Text(
                            ntareas == 0
                                ? '0%'
                                : '${(ncompletos * 100 / ntareas).round()} %',
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          Text('Realizado')
                        ],
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: FutureBuilder(
            future: getTareas(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return WTareaCard(
                      value: estados[index],
                      entregable: snapshot.data![index],
                      onChanged: (estado) async {
                        await updateEntregableEstadoEntity(
                            codigo: snapshot.data![index].codigo,
                            newValue: estado);
                        await refresh();
                        setState(() {});
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
