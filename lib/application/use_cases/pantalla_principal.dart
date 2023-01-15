import 'package:app_seguimiento/application/use_cases/frm_sec_login.dart';
import 'package:app_seguimiento/application/use_cases/pagina_inicio.dart';
import 'package:app_seguimiento/application/use_cases/pagina_perfil.dart';
import 'package:app_seguimiento/application/use_cases/pagina_tareas.dart';
import 'package:flutter/material.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});
  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  PageController pageController = PageController();
  int pageIndex = 0;
  final List<String> titles = ['Inicio', 'Tareas', 'Perfil'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[pageIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FrmSecLogin()));
            },
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        children: [
          const PaginaInicio(),
          PaginaTareas(),
          const PaginaPerfil(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
