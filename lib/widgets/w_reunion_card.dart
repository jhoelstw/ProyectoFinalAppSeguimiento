import 'package:app_seguimiento/domain/entitites/reunion.dart';
import 'package:flutter/material.dart';

class WReunionCard extends StatelessWidget {
  final Reunion reunion;
  final VoidCallback onPressed;
  final VoidCallback onDelete;
  final bool deleteOption;


  const WReunionCard({
    required this.reunion,
    required this.onPressed,
    required this.onDelete,
    required this.deleteOption,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    reunion.codigo,
                    style: const TextStyle(fontSize: 25),
                  ),
                  deleteOption? IconButton(onPressed: onDelete, icon: const Icon(Icons.close)):Container(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 350,
                    child: Text(
                      reunion.titulo,
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                ],
              ),
              const Divider(thickness: 3,),
              Text(
                'Fecha: ${reunion.fecha}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Detalles: ${reunion.detalles}',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: onPressed, child: Text('Ingresar')),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
