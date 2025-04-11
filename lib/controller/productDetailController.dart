import 'dart:convert';

import 'package:amazon_clone/constant/global.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailController {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'stamp': userProvider.user.stamp
        },
        body: jsonEncode({'id': product.id, 'rating': rating}),
      );
      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            showSnackBar(
                context, 'Thank you for giving me rating this product. :');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
