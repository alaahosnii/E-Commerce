import 'package:flutter/material.dart';

class QuantityCard extends StatefulWidget {
  Function? changeQuantity;
  int quantity;
  QuantityCard({super.key, this.changeQuantity, this.quantity = 1});

  @override
  State<QuantityCard> createState() => _QuantityCardState();
}

class _QuantityCardState extends State<QuantityCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color.fromRGBO(0, 65, 130, 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => setState(() {
              if (widget.quantity > 1) {
                widget.quantity--;
                if (widget.changeQuantity != null) {
                  widget.changeQuantity!(widget.quantity);
                }
              }
            }),
            child: Container(
              margin: EdgeInsets.only(left: 5),
              child: Image.asset(
                'assets/images/minus.png',
                width: 25,
              ),
            ),
          ),
          Text(
            widget.quantity.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () => setState(() {
              widget.quantity++;
              if (widget.changeQuantity != null) {
                widget.changeQuantity!(widget.quantity);
              }
            }),
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: Image.asset(
                'assets/images/plus.png',
                width: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
