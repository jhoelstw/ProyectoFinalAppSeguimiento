import 'package:flutter/material.dart';

class WInicioListTile extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String icono;
  final String descripcion;

  const WInicioListTile({
    required this.onPressed,
    required this.title,
    required this.icono,
    required this.descripcion,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 0, 56, 102),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Image.network(
                icono,
                width: 100,
              ),
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const Divider(
                      height: 20.0,
                      thickness: 3.0,
                    ),
                    Text(descripcion),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}