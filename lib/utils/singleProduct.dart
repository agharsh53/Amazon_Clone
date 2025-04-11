import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/view/orderDetails.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatefulWidget {

  Order order;
  SingleProduct({super.key, required this.order});

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, OrderDetails.routeName, arguments:widget.order);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
          child: Container(
            width: 170,
            height: 200,
            padding: const EdgeInsets.all(10),
            child: Image.network(
              widget.order.products[0].images[0],
              fit: BoxFit.fitHeight,
              width: 180,
            ),
          ),
        ),
      ),
    );
  }
}
