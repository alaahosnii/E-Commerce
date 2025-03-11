import 'package:ecommerce/ui/home/tabs/products_tab/products_tab.dart';
import 'package:flutter/material.dart';

class SubCategoryCard extends StatelessWidget {
  String? name;
  String? image;
  String? id;
  SubCategoryCard({required this.name, required this.id, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductsTab.routeName,
          arguments: <String, dynamic>{
            "id": id,
          }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image!,
              width: 65,
              height: 65,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 60,
            height: 35,
            child: Text(
              name!,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
