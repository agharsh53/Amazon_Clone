import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/seller_view/addProduct.dart';
import 'package:amazon_clone/utils/bottom_nav_bar.dart';
import 'package:amazon_clone/view/addressScreen.dart';
import 'package:amazon_clone/view/auth/authScreen.dart';
import 'package:amazon_clone/view/orderDetails.dart';
import 'package:amazon_clone/view/productDetail.dart';
import 'package:amazon_clone/view/searchScreen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_)=>const AuthScreen());
    case BottomNavBar.routeName:
      return MaterialPageRoute(builder: (_)=>const BottomNavBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_)=>const AddProductScreen());
    case SearchScreen.routeName:
      return MaterialPageRoute(builder: (_)=>SearchScreen(searchQuery: routeSettings.arguments as String,));
    case ProductDetailScreen.routeName:
      return MaterialPageRoute(builder: (_)=>ProductDetailScreen(product: routeSettings.arguments as Product));
    case AddressScreen.routeName:
      return MaterialPageRoute(builder: (_)=>AddressScreen( totalAmount: routeSettings.arguments as String,));
    case OrderDetails.routeName:
      return MaterialPageRoute(builder: (_)=>OrderDetails( order: routeSettings.arguments as Order,));


    default:
      return MaterialPageRoute(builder: (_)=> const Scaffold(body: Center(child: Text("Page not exist"),),));
  }
}