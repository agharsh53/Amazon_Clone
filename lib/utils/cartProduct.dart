import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/controller/userController.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:amazon_clone/view/productDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  int index;
  CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  void increaseQuantity(Product product) {
    UserController().addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    UserController().removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromDBtoApp(productCart['product']);
    final quantity = productCart['quantity'];

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: product);
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      product.images[0],
                      height: 120,
                      width: 135,
                      fit: BoxFit.contain,
                    ),
                    Column(
                      children: [
                        Container(
                            width: 235,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              product.name,
                              style: const TextStyle(fontSize: 16),
                              maxLines: 2,
                            )),
                        Container(
                          width: 235,
                          padding: const EdgeInsets.only(left: 20, top: 5),
                          child: const RatingStars(
                            value: 3.5,
                            starColor: Colors.redAccent,
                          ),
                        ),
                        Container(
                            width: 235,
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              'Rs.${product.price.toString()}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              maxLines: 2,
                            )),
                        Container(
                            width: 235,
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: const Text('Free Shipping')),
                        Container(
                            width: 235,
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: const Text(
                              'In Stock',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.teal),
                              maxLines: 2,
                            )),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  decreaseQuantity(product);
                                },
                                child: Container(
                                  width: 35,
                                  height: 32,
                                  alignment: Alignment.center,
                                  color: Colors.grey,
                                  child: const Icon(
                                    Icons.remove,
                                    size: 18,
                                  ),
                                ),
                              ),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black12, width: 1.5),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(0)),
                                  child: SizedBox(
                                    height: 32,
                                    width: 35,
                                    child: Text(
                                      quantity.toString(),
                                      style: const TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              InkWell(
                                onTap: () {
                                  increaseQuantity(product);
                                },
                                child: Container(
                                  width: 35,
                                  height: 32,
                                  alignment: Alignment.center,
                                  color: Colors.grey,
                                  child: const Icon(
                                    Icons.add,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
