import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  String? title;
  bool isSelected;
  CategoryCard({
    super.key,
    this.isSelected = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 70,
      padding: EdgeInsets.all(7),
      color: isSelected ? Colors.white : Colors.transparent,
      child: Row(
        children: [
          Container(
            width: 5,
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)),
          ),
          Container(
            width: 105,
            child: Text(
              title!,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
