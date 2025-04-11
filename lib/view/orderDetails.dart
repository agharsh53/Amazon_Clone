import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  static const String routeName = "/order-details";

  Order order;
  OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int currentStep = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentStep = widget.order.status;
    //currentStep = 2;
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "View order details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Order Date:        ${DateFormat().format(DateTime.fromMicrosecondsSinceEpoch(widget.order.orderedAt))}'),
                      Text('Order Id:           ${widget.order.id}'),
                      Text('Order Total:        \$${widget.order.total}')
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Purchase Details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < widget.order.products.length; i++)
                        Row(
                          children: [
                            Image.network(
                              widget.order.products[i].images[0],
                              height: 120,
                              width: 120,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text('Qty: ${widget.order.quantity[i]}'),
                              ],
                            ))
                          ],
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Tracking',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Stepper(
                    controlsBuilder: (context, details) {
                      if (user.type == "seller") {
                        return TextButton(
                            onPressed: () {
                              setState(() {
                                currentStep += 1;
                              });
                            },
                            child: const Text("Done"));
                      }
                      return const SizedBox();
                    },
                    currentStep: currentStep,
                    steps: [
                      Step(
                          title: const Text("Pendng"),
                          content: const Text('Your order is being processed.'),
                          isActive: currentStep > 0,
                          state: currentStep > 0
                              ? StepState.complete
                              : StepState.indexed),
                      Step(
                          title: const Text("Order Confirmed"),
                          content: const Text('Your order has been confirmed.'),
                          isActive: currentStep > 1,
                          state: currentStep > 1
                              ? StepState.complete
                              : StepState.indexed),
                      Step(
                          isActive: currentStep > 2,
                          state: currentStep > 2
                              ? StepState.complete
                              : StepState.indexed,
                          title: const Text("Dispatched"),
                          content: const Text('Your order has been dispatched.')),
                      Step(
                          isActive: currentStep > 3,
                          state: currentStep > 3
                              ? StepState.complete
                              : StepState.indexed,
                          title: const Text("Delivered"),
                          content: const Text('Your order has been delivered.')),
                    ])
              ],
            ),
          ),
        ));
  }
}
