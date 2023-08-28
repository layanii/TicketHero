import 'package:flutter/material.dart';

class RoundedBottun extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
    const RoundedBottun(
      {super.key, required this.onPressed , required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //on tap
      onTap:onPressed,
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color.fromARGB(133, 0, 150, 135), Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 10,
            )
          ],
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
