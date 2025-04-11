import 'dart:convert';

import 'package:amazon_clone/constant/global.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/model/userModel.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserController {
  void addToCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/add-to-cart"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'stamp': userProvider.user.stamp
          },
          body: jsonEncode({
            'id': product.id,
          }));
      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromMode(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void removeFromCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.delete(Uri.parse("$uri/api/remove-from-cart/${product.id}"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'stamp': userProvider.user.stamp
              },
              body: jsonEncode({
            'id': product.id,
          })
              );
      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromMode(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
