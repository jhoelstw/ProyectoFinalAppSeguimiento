import 'package:flutter/material.dart';

class WTextField extends StatelessWidget {

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final TextInputType textInputType;


  const WTextField({
    required this.controller,
    required this.labelText,
    required this.icon,
    required this.textInputType,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        color: Color.fromARGB(255, 255, 255, 255),
        child: Container(
          height: 60,
          padding: const EdgeInsets.all(10.0),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ThemeData()
                  .colorScheme
                  .copyWith(primary: Color.fromARGB(255, 3, 124, 223)),
            ),
            child: TextField(
              keyboardType: textInputType,
              controller: controller,
              style: const TextStyle(color: Colors.black, fontSize: 20),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                prefixIcon: Icon(
                  icon,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 51, 51, 51)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 3, 124, 223)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


