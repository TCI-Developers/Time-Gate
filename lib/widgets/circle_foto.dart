import 'package:flutter/material.dart';


class CirclePhoto extends StatelessWidget {

  final double maxRadius;
  final String image;

  const CirclePhoto({
    super.key, required this.maxRadius, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        maxRadius: maxRadius,
        backgroundImage: NetworkImage(
          image,
        ),
      ),
    );
  }
}