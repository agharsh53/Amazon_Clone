import 'package:amazon_clone/constant/global.dart';
import 'package:amazon_clone/controller/authController.dart';
import 'package:amazon_clone/router.dart';
import 'package:amazon_clone/utils/bottom_nav_bar.dart';
import 'package:amazon_clone/utils/seller_bottom_nav_bar.dart';
import 'package:amazon_clone/view/auth/authScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/provider_controller/user_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

final AuthController  authController = AuthController();
  @override
  void initState() {
    authController.fetchUserData(context);
    print("STAMP VALUE BY PROVIDER");
   
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(primary: GlobalVariables.primaryColor),
      ),
      home: Provider.of<UserProvider>(context).user.stamp.isNotEmpty ? Provider.of<UserProvider>(context).user.type  =='user' ? const BottomNavBar() :const SellerBottomNavBar() :const AuthScreen()
    );
  }
}
