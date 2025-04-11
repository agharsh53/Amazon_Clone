import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/utils/cartProduct.dart';
import 'package:amazon_clone/view/addressScreen.dart';
import 'package:amazon_clone/view/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    print(user.cart.length);

    
    print("User Cart");
    print(user.cart);
    int subtotal = 0;
    for (var cartItem in user.cart) {
      subtotal += cartItem['quantity'] * cartItem['product']['price'] as int;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value) {
                        Navigator.pushNamed(context, SearchScreen.routeName,
                            arguments: value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 114, 226, 221),
                    Color.fromARGB(255, 162, 236, 233),
                  ],
                  stops: [0.5, 1.0],
                ),
              ),
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Delivery to ${user.name} - ${user.address.isEmpty ? "Adress Not Set" : user.address} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                      top: 2,
                    ),
                    child: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
            Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            "Subtotal",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Rs.$subtotal",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AddressScreen.routeName,arguments: subtotal.toString());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / 2 - 120,
                          vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orangeAccent),
                      child: Text(
                          'Procced To Checkout (${user.cart.length} Items)'),
                    )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: Divider(),
            ),
            
              ListView.separated(
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      endIndent: 10,
                      indent: 10,
                    ),
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: user.cart.length,
                itemBuilder: (context, index) {
                  return CartProduct(index: index);
                },
              ),
            
          ],
        ),
      ),
    );
  }
}
