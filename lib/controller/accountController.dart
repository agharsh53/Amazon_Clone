import 'dart:convert';

import 'package:amazon_clone/constant/global.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AccountController {
  Future<List<Order>> fetchMyOrders({required BuildContext context}) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orders = [];

    try {
      http.Response res = await http.get(Uri.parse('$uri/api/myorders'),
      headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'stamp': userProvider.user.stamp,
          },);

      httpErrorHandler(
            context: context,
            response: res,
            onSuccess: () {
              for(int i=0; i<jsonDecode(res.body).length; i++){
                orders.add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
              }
            });
    } catch (e) {
      showSnackBar(context,e.toString());
    }
    return orders;
  }

}
