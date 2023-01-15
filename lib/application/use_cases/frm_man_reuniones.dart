import 'package:app_seguimiento/domain/entitites/reunion.dart';
import 'package:app_seguimiento/infrastructure/entity_managers/e_entorno.dart';
import 'package:app_seguimiento/infrastructure/entity_managers/e_reunion.dart';
import 'package:app_seguimiento/variables_globales.dart';
import 'package:app_seguimiento/widgets/w_multitext_field.dart';
import 'package:app_seguimiento/widgets/w_reunion_card.dart';
import 'package:app_seguimiento/widgets/w_text_field.dart';
import 'package:flutter/material.dart';

class FrmManReuniones extends StatelessWidget {
  FrmManReuniones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reuniones')),
      body: Global.esLider! ? LiderVersion() : const ColaboradorVersion(),
    );
  }
}

class LiderVersion extends StatelessWidget {
  LiderVersion({super.key});

  final TextEditingController codigo = TextEditingController();
  final TextEditingController titulo = TextEditingController();
  final TextEditingController link = TextEditingController();
  final TextEditingController fecha = TextEditingController();
  final TextEditingController detalles = TextEditingController();

  // SUBRUTINA
  Future agregarReunion() async {
    if (codigo.text.isEmpty) return;
    if (titulo.text.isEmpty) return;
    if (link.text.isEmpty) return;
    if (fecha.text.isEmpty) return;
    if (detalles.text.isEmpty) return;

    await addEntornoReunionEntity(
      reunion: Reunion(
        codigo: codigo.text,
        detalles: detalles.text,
        fecha: fecha.text,
        link: link.text,
        titulo: titulo.text,
      ),
      codigo: Global.entorno!.codigo,
    );

    codigo.clear();
    titulo.clear();
    link.clear();
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
                      textInputType: TextInputType.url,
                      controller: link,
                      labelText: 'Link',
                      icon: Icons.link,
                    ),
                    WTextField(
                      textInputType: TextInputType.url,
                      controller: fecha,
                      labelText: 'Fecha',
                      icon: Icons.link,
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
                          await agregarReunion();
                        },
                        child: const Text('Crear'),
                      ),
                    ),
                  ],
                ),
                const Listado()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Listado extends StatefulWidget {
  const Listado({super.key});

  @override
  State<Listado> createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {
  Future<List<Reunion>> getReuniones() async {
    return await getEntornoReunionesEntity(codigo: Global.entorno!.codigo);
  }

  Future<void> deleteReunion(
      {required String entornoCodigo, required String reunionCodigo}) async {
    await deleteEntornoReunionEntity(
        entornoCodigo: entornoCodigo, reunionCodigo: reunionCodigo);
    await deleteReunionEntity(codigo: reunionCodigo);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getReuniones(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return WReunionCard(
                reunion: snapshot.data![index],
                onPressed: () {},
                onDelete: () async {
                  await deleteReunion(
                    entornoCodigo: Global.entorno!.codigo,
                    reunionCodigo: snapshot.data![index].codigo,
                  ).then((value) {
                    setState(() {});
                  });
                },
                deleteOption: Global.esLider!,
              );
            },
          );
        }
      },
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
