import 'package:flutter/material.dart';

class ColorCard extends StatelessWidget {
  bool isSelected;
  Color? color;
  ColorCard({super.key, this.isSelected = false, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color,
      ),
      child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
    );
  }
}
