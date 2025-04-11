import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone/constant/global.dart';

class AdminController {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('duo5szmk2', 'b8qsiggg');

      List<String> imageUrl = [];
      //'https://res.cloudinary.com/duo5szmk2/image/upload/v1731526659/iphone%2012/hxqkzjyls7yxbkkojxuq.webp'
      for (var img in images) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(img.path, folder: name));

        imageUrl.add(res.secureUrl);
        print(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrl,
          category: category,
          price: price);
      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'stamp': userProvider.user.stamp.toString(),
          },
          body: product.toJson());
      print('Type of res: ${res.runtimeType}');

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            showSnackBar(context, "Product Added Succesfully");
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-products"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'stamp': userProvider.user.stamp.toString(),
        },
      );

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct(
      {required BuildContext context,
      required VoidCallback onSuccess,
      required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res =
          await http.post(Uri.parse("$uri/admin/delete-product"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'stamp': userProvider.user.stamp.toString(),
              },
              body: jsonEncode({'id': product.id}));

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
