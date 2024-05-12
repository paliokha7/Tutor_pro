import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tutor_pro/theme/pallete.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  final String svgPicture;
  const ProfileButton(
      {super.key,
      required this.text,
      required this.color,
      required this.svgPicture,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Pallete.white,
        borderRadius: BorderRadius.circular(12),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 24, right: 12),
                child: SvgPicture.asset(
                  svgPicture,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                )),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
