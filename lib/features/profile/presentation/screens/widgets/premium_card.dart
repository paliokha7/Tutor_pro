import 'package:flutter/material.dart';
import 'package:tutor_pro/core/common/second_button.dart';
import 'package:tutor_pro/theme/pallete.dart';

class ExtendedCard extends StatelessWidget {
  final String title;
  final String price;
  final String? feature;
  final Function function;
  final String text;
  final Color color;

  const ExtendedCard(
      {super.key,
      required this.title,
      required this.price,
      this.feature,
      required this.function,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Pallete.black, width: 2.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Pallete.black),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Pallete.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Надає стислий твір та коспекти',
            style: TextStyle(fontSize: 16.0, color: Pallete.black),
          ),
          const SizedBox(height: 8.0),
          if (feature != null)
            Column(
              children: [
                const SizedBox(height: 8.0),
                Text(
                  feature!,
                  style: const TextStyle(fontSize: 16.0, color: Pallete.black),
                ),
              ],
            ),
          const SizedBox(height: 24.0),
          SecondButton(text: text, function: function)
        ],
      ),
    );
  }
}
