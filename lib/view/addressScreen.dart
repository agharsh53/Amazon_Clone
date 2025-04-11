import 'package:amazon_clone/constant/google_pay_conf.dart';
import 'package:amazon_clone/controller/addressControler.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pay/pay.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String addressToBeUsed = "";

  final _addressFormKey = GlobalKey<FormState>();

  final TextEditingController addressLine1Controller = TextEditingController();

  final TextEditingController addressLine2Controller = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController distController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController landmarkController = TextEditingController();

  final TextEditingController pincodeController = TextEditingController();

  final AddressController addressController = AddressController();

  onGooglePaySuccess(res) {
    if (Provider.of<UserProvider>(context, listen: false).user.address.isEmpty) {
      addressController.saveUserAddress(
          context: context, address: addressToBeUsed);
      //order placed

    }
    addressController.placeOrder(
        context: context,
        address: addressToBeUsed,
        total: double.parse(widget.totalAmount));
  }

  void payment(String addressFromProvider) {
    addressToBeUsed = "";

    bool isFormFill = addressLine1Controller.text.isNotEmpty ||
        addressLine2Controller.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        distController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty;
    if (isFormFill) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${addressLine1Controller.text}, ${addressLine2Controller.text}, ${cityController.text}, ${distController.text}, ${landmarkController.text}, ${pincodeController.text}';
      } else {
        throw Exception("Please Enter all values!");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, "Error");
    }
    onGooglePaySuccess("res");
  }

  final List<PaymentItem> _paymentItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentItems.add(PaymentItem(
      label: 'Total Payable Amount',
      amount: widget.totalAmount,
      status: PaymentItemStatus.final_price,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your Address"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              address.isNotEmpty
                  ? Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: Text(address),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("OR"),
                      ],
                    )
                  : const SizedBox(),
              Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: addressLine1Controller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is mendatory";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: "Address Line 1",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: addressLine2Controller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is mendatory";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: "Address Line 2",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: cityController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is mendatory";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: "Town/City",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: distController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is mendatory";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: "District",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: stateController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is mendatory";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: "State",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: landmarkController,
                        decoration: const InputDecoration(
                            hintText: "Landmark",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: pincodeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is mendatory";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: "Pincode",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GooglePayButton(
                        width: double.infinity,
                        type: GooglePayButtonType.order,
                        paymentConfiguration:
                            PaymentConfiguration.fromJsonString(
                                defaultGooglePay),
                        paymentItems: _paymentItems,
                        onPaymentResult: (res) {
                          onGooglePaySuccess(res);
                        },
                        onPressed: () => payment(address),
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
