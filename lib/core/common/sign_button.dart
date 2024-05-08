import 'package:flutter/material.dart';
import 'package:tutor_pro/theme/pallete.dart';

class SignButton extends StatelessWidget {
  final String text;
  final Function function;
  const SignButton({super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Add null check
            offset: const Offset(7, 7),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => function(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.yellow,
          minimumSize: const Size(double.infinity, 49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(width: 2, color: Pallete.black),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Pallete.black),
        ),
      ),
    );
  }
}
