import 'dart:convert';
class Rating{
  final String userId;
  final double rating;

  Rating({
    required this.userId,
    required this.rating
  });

  Map<String,dynamic> fromAppToDB(){
    return {
      'userId' : userId,
      'rating' : rating,
    };
  }

  factory Rating.fromDBtoApp(Map<String, dynamic> map){
    return Rating(
      userId : map['userId'] ?? '',
      rating : double.parse(map['rating'].toString()) ?? 0.0

    );
  }
  String toJson() => json.encode(fromAppToDB());
  factory Rating.fromJson(String source) =>
      Rating.fromDBtoApp(jsonDecode(source));
}

