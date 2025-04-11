import 'package:amazon_clone/controller/accountController.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/utils/account_button.dart';
import 'package:amazon_clone/utils/singleProduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Order>? orders;
  final AccountController accountController = AccountController();
  fetchOrder() async {
    orders = await accountController.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.blueAccent),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "assets/images/amazon_logo.png",
                  width: 90,
                  height: 50,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                    size: 30,
                  )),
              // SizedBox(width: 10,),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  )),
            ],
          ),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                "Hey👋! ${user.name}",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileButton(
                  text: "Your Orders",
                  onTap: () {},
                ),
                ProfileButton(
                  text: "Your Wishlist",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileButton(
                  text: "Seller Mode",
                  onTap: () {},
                ),
                ProfileButton(
                  text: "Logout",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            orders == null
                ? const CircularProgressIndicator()
                : SizedBox( width: MediaQuery.of(context).size.width,
                height: 200,
                  child:ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    final product = orders![index];
                    return SingleProduct(order: product);
                  })),
          ]),
    );
  }
}
