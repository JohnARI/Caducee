import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final AssetImage image;
  final String title;
  final String subtitle;
  final Color color;
  final Widget button;

  const ResultPage({super.key, required this.title, required this.subtitle, required this.image, required this.color, required this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image(
          image: image,
          fit: BoxFit.fitWidth,
        ),
        Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        button,
      ],
    ),
  );
  }
}