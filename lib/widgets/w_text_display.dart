import 'package:flutter/material.dart';

class WTextDisplay extends StatelessWidget {
  final String title;
  final String value;
  const WTextDisplay({
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              color: Color.fromARGB(255, 31, 29, 29),
            ),
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: value,
                hintStyle: TextStyle(fontSize: 20.0),
                contentPadding: EdgeInsets.symmetric(vertical: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}