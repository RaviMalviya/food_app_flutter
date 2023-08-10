import 'package:flutter/material.dart';

class ImageTextCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const ImageTextCard({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 16,
          height: 16,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 4.0),
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}