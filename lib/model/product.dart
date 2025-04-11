import 'dart:convert';
import 'package:amazon_clone/model/rating.dart';
class Product {
  String name;
  String description;
  int quantity;
  List<dynamic> images;
  String category;
  double price;
  String? id;
  List<Rating>? rating;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.rating,
  });

  Map<String, dynamic> fromAppToDB() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'rating': rating,
    };
  }

  factory Product.fromDBtoApp(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? '',
      images: map['images'] ?? '',
      category: map['category'] ?? '',
      price: (map['price'] is int) ? (map['price'] as int).toDouble() : (map['price'] ?? 0.0),
      id: map['_id'] ,
      rating: map["ratings"] != null ? List<Rating>.from(map['ratings'].map((x)=>Rating.fromDBtoApp(x))) : null,
    );
  }

  String toJson() => json.encode(fromAppToDB());
  factory Product.fromJson(String source) =>
      Product.fromDBtoApp(jsonDecode(source));
}
