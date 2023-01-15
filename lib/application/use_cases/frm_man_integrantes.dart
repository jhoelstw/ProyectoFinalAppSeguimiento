import 'package:app_seguimiento/domain/entitites/usuario.dart';
import 'package:app_seguimiento/infrastructure/entity_managers/e_entorno.dart';
import 'package:app_seguimiento/infrastructure/entity_managers/e_usuario.dart';
import 'package:app_seguimiento/variables_globales.dart';
import 'package:app_seguimiento/widgets/w_integrante_card.dart';
import 'package:app_seguimiento/widgets/w_text_field.dart';
import 'package:flutter/material.dart';

class FrmManIntegrantes extends StatefulWidget {
  const FrmManIntegrantes({super.key});

  @override
  State<FrmManIntegrantes> createState() => _FrmManIntegrantesState();
}

class _FrmManIntegrantesState extends State<FrmManIntegrantes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Integrantes')),
      body: Global.esLider! ? LiderVersion() : const ColaboradorVersion(),
    );
  }
}

class LiderVersion extends StatelessWidget {
  LiderVersion({super.key});

  final TextEditingController codigo = TextEditingController();
  final TextEditingController nombres = TextEditingController();
  final TextEditingController apellidos = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController celular = TextEditingController();

  //SUBRUTINA
  Future agregarColaborador() async {
    if (codigo.text.isEmpty) return;
    if (nombres.text.isEmpty) return;
    if (apellidos.text.isEmpty) return;
    if (email.text.isEmpty) return;
    if (celular.text.isEmpty) return;
    await addEntornoColaboradorEntity(
      usuario: Usuario(
        apellidos: apellidos.text,
        celular: celular.text,
        codigo: codigo.text,
        email: email.text,
        nombre: nombres.text,
      ),
      codigo: Global.entorno!.codigo,
    );
    codigo.clear();
    nombres.clear();
    apellidos.clear();
    email.clear();
    celular.clear();
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
                      labelText: 'Codigo de usuario',
                      icon: Icons.person,
                    ),
                    WTextField(
                      textInputType: TextInputType.name,
                      controller: nombres,
                      labelText: 'Nombres',
                      icon: Icons.person,
                    ),
                    WTextField(
                      textInputType: TextInputType.name,
                      controller: apellidos,
                      labelText: 'Apellidos',
                      icon: Icons.person,
                    ),
                    WTextField(
                      textInputType: TextInputType.emailAddress,
                      controller: email,
                      labelText: 'Email',
                      icon: Icons.person,
                    ),
                    WTextField(
                      textInputType: TextInputType.phone,
                      controller: celular,
                      labelText: 'Numero de celular',
                      icon: Icons.person,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await agregarColaborador();
                        },
                        child: const Text('Agregar'),
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
  const Listado({
    Key? key,
  }) : super(key: key);

  @override
  State<Listado> createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {
  // SUBRUTINAS
  Future<Usuario> getLider() async {
    return await getUsuarioEntity(codigo: Global.entorno!.codLider);
  }

  Future<List<Usuario>> getColaboradores() async {
    return await getEntornoColaboradoresEntity(codigo: Global.entorno!.codigo);
  }

  Future<void> deleteColaborador(
      {required String entornoCodigo,
      required String colaboradorCodigo}) async {
    await deleteEntornoColaboradorEntity(
        entornoCodigo: entornoCodigo, colaboradorCodigo: colaboradorCodigo);
    await deleteUsuarioEntity(codigo: colaboradorCodigo);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          color: const Color.fromARGB(255, 0, 56, 102),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Lider'),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: getLider(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return WIntegranteCard(
                deleteOption: false,
                onDelete: () {},
                usuario: snapshot.data!,
              );
            }
          },
        ),
        Card(
          color: const Color.fromARGB(255, 0, 56, 102),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Colaboradores'),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: getColaboradores(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: [
                  for (int i = 0; i < snapshot.data!.length; i++)
                    WIntegranteCard(
                      deleteOption: Global.esLider!,
                      onDelete: () async {
                        await deleteColaborador(
                                entornoCodigo: Global.entorno!.codigo,
                                colaboradorCodigo: snapshot.data![i].codigo)
                            .then((value) {
                          setState(() {});
                        });
                      },
                      usuario: snapshot.data![i],
                    ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
