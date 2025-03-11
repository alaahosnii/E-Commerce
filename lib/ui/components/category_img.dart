import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CategoryIcon extends StatelessWidget {
  String imageUrl;
  CategoryIcon(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
