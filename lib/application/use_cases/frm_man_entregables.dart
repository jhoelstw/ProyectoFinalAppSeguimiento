import 'package:app_seguimiento/domain/entitites/entregable.dart';
import 'package:app_seguimiento/infrastructure/entity_managers/e_entorno.dart';
import 'package:app_seguimiento/infrastructure/entity_managers/e_entregable.dart';
import 'package:app_seguimiento/variables_globales.dart';
import 'package:app_seguimiento/widgets/w_entregable_card.dart';
import 'package:app_seguimiento/widgets/w_multitext_field.dart';
import 'package:app_seguimiento/widgets/w_text_field.dart';
import 'package:flutter/material.dart';

class FrmManEntregables extends StatelessWidget {
  FrmManEntregables({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entregables')),
      body: Global.esLider! ? LiderVersion() : ColaboradorVersion(),
    );
  }
}

class LiderVersion extends StatelessWidget {
  LiderVersion({super.key});

  final TextEditingController codigo = TextEditingController();
  final TextEditingController titulo = TextEditingController();
  final TextEditingController responsable = TextEditingController();
  final TextEditingController fecha = TextEditingController();
  final TextEditingController detalles = TextEditingController();

  // SUBRUTINA
  Future agregarEntregable() async {
    if (codigo.text.isEmpty) return;
    if (titulo.text.isEmpty) return;
    if (responsable.text.isEmpty) return;
    if (fecha.text.isEmpty) return;
    if (detalles.text.isEmpty) return;

    await addEntornoEntregableEntity(
        entregable: Entregable(
          codigo: codigo.text,
          titulo: titulo.text,
          responsable: responsable.text,
          fechaDeEntrega: fecha.text,
          detalles: detalles.text,
          estado: false,
        ),
        codigo: Global.entorno!.codigo);

    codigo.clear();
    titulo.clear();
    responsable.clear();
    fecha.clear();
    detalles.clear();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                text: 'Nuevo',
              ),
              Tab(
                text: 'Lista',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Llene el siguiente formulario:',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    WTextField(
                      textInputType: TextInputType.name,
                      controller: codigo,
                      labelText: 'Codigo',
                      icon: Icons.person,
                    ),
                    WTextField(
                      textInputType: TextInputType.name,
                      controller: titulo,
                      labelText: 'Titulo',
                      icon: Icons.person,
                    ),
                    WTextField(
                      textInputType: TextInputType.name,
                      controller: responsable,
                      labelText: 'Responsable',
                      icon: Icons.person,
                    ),
                    WTextField(
                      textInputType: TextInputType.name,
                      controller: fecha,
                      labelText: 'Fecha de entrega',
                      icon: Icons.person,
                    ),
                    WMultiTextField(
                      controller: detalles,
                      labelText: 'Detalles',
                      icon: Icons.text_fields,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await agregarEntregable();
                        },
                        child: const Text('Crear'),
                      ),
                    ),
                  ],
                ),
                const Listado(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ColaboradorVersion extends StatelessWidget {
  const ColaboradorVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return const Listado();
  }
}

class Listado extends StatefulWidget {
  const Listado({super.key});

  @override
  State<Listado> createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {

  Future<List<Entregable>> getEntregables() async {
    return await getEntornoEntregablesEntity(codigo: Global.entorno!.codigo);
  }

  Future<void> deleteEntregable(
      {required String entornoCodigo, required String entregableCodigo}) async {
    await deleteEntornoEntregableEntity(entornoCodigo: entornoCodigo, entregableCodigo: entregableCodigo);
    await deleteEntregableEntity(codigo: entregableCodigo);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getEntregables(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return WEntregableCard(
                deleteOption: Global.esLider!,
                onDelete: () async {
                  await deleteEntregable(
                    entornoCodigo: Global.entorno!.codigo,
                    entregableCodigo: snapshot.data![index].codigo,
                  ).then((value) {
                    setState(() {});
                  });
                },
                entregable: snapshot.data![index],
              );
            },
          );
        }
      },
    );
  }
}
