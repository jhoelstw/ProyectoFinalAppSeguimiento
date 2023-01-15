import 'package:flutter/material.dart';

class WTextButton extends StatelessWidget {
  final String leadingText;
  final String buttonText;
  final VoidCallback onPressed;

  const WTextButton({
    required this.leadingText,
    required this.buttonText,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            leadingText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.green,
                fontSize: 20
              ),
            ),
          )
        ],
      ),
    );
  }
}
