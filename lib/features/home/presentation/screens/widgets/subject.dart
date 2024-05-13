import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tutor_pro/theme/pallete.dart';

class SubjectCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  const SubjectCard(
      {super.key,
      required this.color,
      required this.title,
      required this.subtitle});
  final double cardHeight = 150;
  final double cardWidth = double.infinity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 20),
      child: Container(
        height: cardHeight,
        width: cardWidth,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Pallete.black.withOpacity(0.5),
              offset: const Offset(7, 7),
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Pallete.purple,
                fontFamily: 'Fixel',
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 52.0),
            Text(
              subtitle,
              maxLines: null,
              style: const TextStyle(
                  color: Pallete.black,
                  fontFamily: 'Fixel',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
