import 'dart:convert';

import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/utils/bottom_nav_bar.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/global.dart';
import '../model/userModel.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Future<void> signUpUser(
      {required BuildContext context,
      required String email,
      required String name,
      required String password}) async {
    try {
      // ignore: unused_local_variable
      User user = User(
          email: email,
          name: name,
          password: password,
          address: '',
          stamp: '',
          type: '',
          id: '',
          cart: []);
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: jsonEncode(user.fromAppToDB()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            showSnackBar(context,
                "Account Created Succesfully! Please login with same credential.");
          });
    } catch (e) {
      showSnackBar(context, "Error Occured - ${e.toString()}");
    }
  }

  Future<void> signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      // ignore: unused_local_variable

      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () async {
            showSnackBar(context, "Welcome Back!.");
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            print("STAMP VALUE IS HERE");
            print(jsonDecode(res.body)["stamp"]);
            await sharedPreferences.setString(
                "stamp", jsonDecode(res.body)["stamp"]);

            Navigator.pushNamedAndRemoveUntil(
                context, BottomNavBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, "Error Occured - ${e.toString()}");
    }
  }

  Future<void> fetchUserData(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? stamp = sharedPreferences.getString("stamp");
      print("SAVED STAMP VALUE");
      print(stamp);
      if (stamp == null) {
        sharedPreferences.setString("stamp", "");
      }

      var stampRes = await http.post(Uri.parse("$uri/validateStamp"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'stamp': stamp!
          });

      var response = jsonDecode(stampRes.body);
      print("I AM CALLING3");
      print(response);
      if (response == true) {
        http.Response userRes = await http.get(Uri.parse("$uri/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'stamp': stamp
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      print(e.toString());
       showSnackBar(context, e.toString());
    }
    try {
      final response = await http.get(Uri.parse('http://192.168.18.147:3000'));
      if (response.statusCode == 200) {
        // Process the response
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Connection error: $e');
    }
  }
}