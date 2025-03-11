import 'package:flutter/material.dart';

class SizeCard extends StatelessWidget {
  bool isSelected;
  String? size;
  SizeCard({super.key, this.isSelected = false, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isSelected ? Color.fromRGBO(0, 65, 130, 1) : Colors.white),
      child: Center(
        child: Container(
          child: Text(
            size!,
            style: TextStyle(
                color:
                    isSelected ? Colors.white : Color.fromRGBO(0, 65, 130, 1),
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
      ),
    );
  }
}
