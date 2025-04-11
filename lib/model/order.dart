import 'dart:convert';

import 'package:amazon_clone/model/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final double total;

  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.total,
  });

  Map<String, dynamic> fromAppToDB() {
    return {
      'id': id,
      'products': products,
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderAt': orderedAt,
      'status': status,
      'total': total,
    };
  }

  factory Order.fromDBtoApp(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(map['products'].map((x)=>Product.fromDBtoApp(x['product']))),
      quantity: List<int>.from(map['products'].map((x)=>x['quantity'])),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0 ,
      total: map["total"]?.toDouble() ?? 0.0 ,
    );
  }

   String toJson() => json.encode(fromAppToDB());
  factory Order.fromJson(String source) =>
      Order.fromDBtoApp(jsonDecode(source));

}
