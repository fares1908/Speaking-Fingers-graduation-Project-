import 'package:flutter/material.dart';

class Vide extends StatelessWidget {
  final bool isFavorited;

  Vide({
    super.key,
    required this.isFavorited,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
    );
  }
}